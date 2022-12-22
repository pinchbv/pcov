import 'dart:io';

import 'package:yaml/yaml.dart';

/// Gets the package name from the pubspec.yaml file
class GetPackageName {
  /// Returns the package name defined in the pubspec.yaml file.
  String call() {
    final pubspec = loadYaml(File('pubspec.yaml').readAsStringSync());
    final packageName = pubspec['name'];
    return packageName;
  }
}
