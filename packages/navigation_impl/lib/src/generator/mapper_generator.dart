import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
// Импортируем только аннотацию, чтобы не тянуть за собой весь API с его part-файлами
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

    for (final method in registryElement.methods) {
      final methodName = method.name;
      final specName = '${_capitalize(methodName)}RouteSpec';
      final autoRouteName = '${_capitalize(methodName)}Route';

      buffer.write('      $specName(');
      if (method.parameters.isNotEmpty) {
        final params = method.parameters.map((p) => ':final ${p.name}').join(', ');
        buffer.write(params);
      }
      buffer.write(') => ');

      buffer.write('$autoRouteName(');
      if (method.parameters.isNotEmpty) {
        final args = method.parameters.map((p) => '${p.name}: ${p.name}').join(', ');
        buffer.write(args);
      }
      buffer.writeln('),');
    }

    buffer.writeln("      _ => throw UnimplementedError('Unknown route: \$destination'),");
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
