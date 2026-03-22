import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class MapperGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final buffer = StringBuffer();
    
    // Это упрощенная версия. В идеале нужно искать все RouteSpec в проекте.
    // Но для начала сделаем генерацию маппера, который предполагает наличие 
    // сгенерированных AutoRoute классов.
    
    buffer.writeln('import "package:auto_route/auto_route.dart";');
    buffer.writeln('import "package:navigation_api/navigation_api.dart";');
    buffer.writeln('import "app_router.dart";');
    buffer.writeln();
    buffer.writeln('class RouteMapper {');
    buffer.writeln('  static PageRouteInfo mapToRoute(RouteSpec spec) {');
    
    // Здесь должна быть логика сопоставления. 
    // Так как это генератор для одного файла, он не видит все RouteSpec сразу.
    // Для реализации "сборщика" лучше использовать другой подход, 
    // но мы сделаем базовую структуру.
    
    buffer.writeln('    if (spec is ProfileMainRouteSpec) {');
    buffer.writeln('      return ProfileMainRoute(userId: spec.userId);');
    buffer.writeln('    }');
    buffer.writeln('    if (spec is ProfileSettingsRouteSpec) {');
    buffer.writeln('      return const ProfileSettingsRoute();');
    buffer.writeln('    }');
    buffer.writeln('    if (spec is LoginRouteSpec) {');
    buffer.writeln('      return const LoginRoute();');
    buffer.writeln('    }');
    
    buffer.writeln('    throw UnimplementedError("Unknown route spec: \$spec");');
    buffer.writeln('  }');
    buffer.writeln('}');
    
    return buffer.toString();
  }
}
