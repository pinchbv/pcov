import 'dart:io';

import 'package:yaml/yaml.dart';

class GetPackageName {
  String call() {
    final pubspec = loadYaml(File('pubspec.yaml').readAsStringSync());
    final packageName = pubspec['name'];
    return packageName;
  }
}
