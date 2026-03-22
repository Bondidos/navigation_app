import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:navigation_api/src/annotations/generate_mapper.dart';

Builder mapperBuilder(BuilderOptions options) =>
    SharedPartBuilder([const MapperGenerator()], 'mapper');

class MapperGenerator extends GeneratorForAnnotation<GenerateMapper> {
  const MapperGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final registryType = annotation.read('registry').typeValue;
    if (registryType is! InterfaceType) {
      throw InvalidGenerationSourceError('Registry must be a class.');
    }

    final registryElement = registryType.element as ClassElement;
    final buffer = StringBuffer();

    buffer.writeln('// Generated RouteMapper for ${registryElement.name}');
    buffer.writeln('abstract class RouteMapper {');
    buffer.writeln('  static PageRouteInfo map(RouteSpec destination) {');
    buffer.writeln('    return switch (destination) {');

    // Для каждого метода в AppRoutes ищем соответствующую страницу
    for (final method in registryElement.methods) {
      final specName = '${_capitalize(method.name)}RouteSpec';
      final autoRouteName = '${_capitalize(method.name)}Route';

      // Генератор теперь ВСЕГДА передает объект spec в AutoRoute.
      // Это требует, чтобы страницы в impl принимали 'spec' в конструкторе.
      buffer.writeln('      $specName spec => $autoRouteName(spec: spec),');
    }

    buffer.writeln(
      "      _ => throw UnimplementedError('Unknown route: \$destination'),",
    );
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
