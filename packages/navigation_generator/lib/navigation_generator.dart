import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/generator.dart';
import 'src/mapper_generator.dart';

Builder navigationGenerator(BuilderOptions options) =>
    SharedPartBuilder([NavigationGenerator()], 'navigation');

Builder mapperGenerator(BuilderOptions options) =>
    LibraryBuilder(MapperGenerator(), generatedExtension: '.mapper.g.dart');
