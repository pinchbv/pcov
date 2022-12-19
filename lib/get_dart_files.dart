import 'dart:io';

class GetDartFiles {
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
