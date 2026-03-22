import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import '../annotations/generate_navigation.dart';

Builder navigationBuilder(BuilderOptions options) =>
    SharedPartBuilder([const NavigationGenerator()], 'navigation');

class NavigationGenerator extends GeneratorForAnnotation<GenerateNavigation> {
  const NavigationGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@GenerateNavigation can only be applied to classes.',
        element: element,
      );
    }

    final buffer = StringBuffer();
    
    for (final method in element.methods) {
      _generateRouteSpec(buffer, method);
    }

    return buffer.toString();
  }

  void _generateRouteSpec(StringBuffer buffer, MethodElement method) {
    final specName = '${_capitalize(method.name)}RouteSpec';
    
    String returnType = method.returnType.getDisplayString(withNullability: true);
    if (method.returnType is VoidType) {
      returnType = 'void';
    }

    buffer.writeln('class $specName extends RouteSpec<$returnType> {');

    // Поля
    for (final param in method.parameters) {
      final type = param.type.getDisplayString(withNullability: true);
      buffer.writeln('  final $type ${param.name};');
    }

    // Конструктор
    if (method.parameters.isEmpty) {
      buffer.writeln('  const $specName();');
    } else {
      buffer.writeln('  const $specName({');
      for (final param in method.parameters) {
        final requiredStr = param.isRequiredNamed ? 'required ' : '';
        buffer.writeln('    $requiredStr this.${param.name},');
      }
      buffer.writeln('  });');
    }

    buffer.writeln('}');
    buffer.writeln();
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
