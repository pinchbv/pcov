import 'dart:io';

/// Gets all the Dart files for a given directory.
class GetDartFiles {
  /// Gets all the Dart files for the given [directory]
  List<File> call({
    String directory = 'lib',
  }) {
    final directoryToCheck = Directory(directory);
    return directoryToCheck
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .toList();
  }
}
