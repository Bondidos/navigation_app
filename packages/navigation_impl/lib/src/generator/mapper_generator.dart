import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:navigation_api/navigation_api.dart';

Builder mapperBuilder(BuilderOptions options) =>
    SharedPartBuilder([const MapperGenerator()], 'mapper');

class MapperGenerator extends GeneratorForAnnotation<GenerateMapper> {
  const MapperGenerator();

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final registryTypeValue = annotation.read('registry').typeValue;
    if (registryTypeValue is! InterfaceType) {
      throw InvalidGenerationSourceError('Registry must be a class.');
    }

    final registryElement = registryTypeValue.element as ClassElement;
    
    // Ищем соответствия Spec -> AutoRoute в проекте
    final mappings = await _discoverMappings(buildStep);

    final buffer = StringBuffer();
    buffer.writeln('// Generated RouteMapper for ${registryElement.name}');
    
    // Генерируем обычный класс для поддержки инъекции зависимостей
    buffer.writeln('class RouteMapper {');
    buffer.writeln('  const RouteMapper();');
    buffer.writeln('');
    buffer.writeln('  PageRouteInfo map(RouteSpec destination) {');
    buffer.writeln('    return switch (destination) {');

    for (final method in registryElement.methods) {
      final specName = '${_capitalize(method.name)}RouteSpec';
      final autoRouteName = mappings[specName];
      
      if (autoRouteName != null) {
        buffer.writeln('      $specName spec => $autoRouteName(spec: spec),');
      } else {
        // Фолбек на стандартное именование, если страница не найдена в текущем скане
        final fallbackName = '${_capitalize(method.name)}Route';
        buffer.writeln('      $specName spec => $fallbackName(spec: spec),');
      }
    }

    buffer.writeln(
      "      _ => throw UnimplementedError('Unknown route: \$destination'),",
    );
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  /// Умный поиск всех страниц в проекте, которые помечены @RoutePage
  Future<Map<String, String>> _discoverMappings(BuildStep buildStep) async {
    final mappings = <String, String>{};
    final resolver = buildStep.resolver;
    
    final libraries = await resolver.libraries.toList();
    
    for (final lib in libraries) {
      final uri = lib.source.uri;
      
      // Фильтруем библиотеки, чтобы не сканировать лишнего
      final isOurPackage = uri.scheme == 'package' && 
          (uri.path.startsWith('navigation_impl/') || uri.path.contains('feature_'));
          
      if (!isOurPackage) continue;

      for (final topLevelElement in lib.topLevelElements) {
        if (topLevelElement is ClassElement) {
          final routePageAnnot = _getRoutePageAnnotation(topLevelElement);
          if (routePageAnnot != null) {
            for (final constructor in topLevelElement.constructors) {
              for (final parameter in constructor.parameters) {
                if (parameter.name == 'spec') {
                  final typeName = parameter.type.getDisplayString(withNullability: false);
                  
                  final customName = routePageAnnot.peek('name')?.stringValue;
                  final autoRouteName = customName != null 
                      ? '${_capitalize(customName)}Route'
                      : _getAutoRouteName(topLevelElement.name);
                      
                  mappings[typeName] = autoRouteName;
                }
              }
            }
          }
        }
      }
    }
    return mappings;
  }

  ConstantReader? _getRoutePageAnnotation(ClassElement element) {
    for (final annot in element.metadata) {
      final value = annot.computeConstantValue();
      final typeName = value?.type?.getDisplayString(withNullability: false);
      if (typeName == 'RoutePage') {
        return ConstantReader(value);
      }
    }
    return null;
  }

  String _getAutoRouteName(String className) {
    String name = className;
    const suffixes = ['Page', 'Screen', 'View', 'Widget'];
    for (final s in suffixes) {
      if (name.endsWith(s)) {
        name = name.substring(0, name.length - s.length);
        break;
      }
    }
    return '${name}Route';
  }

  String _capitalize(String s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
}
