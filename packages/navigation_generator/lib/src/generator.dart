import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:navigation_api/navigation_api.dart';
import 'package:source_gen/source_gen.dart';

class NavigationGenerator extends GeneratorForAnnotation<GenerateRoute> {
  const NavigationGenerator();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@GenerateRoute can only be applied to classes.',
      );
    }

    final routeName = annotation.read('routeName').stringValue;
    final buffer = StringBuffer();

    // В Dart нет вложенных классов в рантайме, но через анализатор
    // мы можем найти классы, объявленные в том же файле, или использовать
    // поля класса-аннотации как дескрипторы.
    // Решение: Генерируем RouteSpec на основе самого аннотированного класса.
    
    _generateRouteSpec(buffer, routeName, element);

    return DartFormatter().format(buffer.toString());
  }

  void _generateRouteSpec(StringBuffer buffer, String routePath, ClassElement element) {
    final className = '${element.name}Spec';
    
    buffer.writeln('/// Generated RouteSpec for ${element.name}');
    buffer.writeln('class $className extends RouteSpec {');

    final fields = element.fields.where((f) => !f.isStatic && !f.isConst).toList();

    // Поля
    for (final field in fields) {
      buffer.writeln('  final ${field.type.getDisplayString(withNullability: true)} ${field.name};');
    }

    // Конструктор
    buffer.writeln('  const $className({');
    for (final field in fields) {
      final isNullable = field.type.nullabilitySuffix != NullabilitySuffix.none;
      final requiredStr = isNullable ? '' : 'required ';
      buffer.writeln('    $requiredStr this.${field.name},');
    }
    buffer.writeln('  });');

    // routeType getter
    buffer.writeln("  @override String get routeType => '$routePath';");

    // toParams
    buffer.writeln('  @override Map<String, dynamic> toParams() => {');
    for (final field in fields) {
      buffer.writeln("    '${field.name}': ${field.name},");
    }
    buffer.writeln('  };');

    buffer.writeln('}');
    buffer.writeln();
  }
}
