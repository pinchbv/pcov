import 'dart:io';

class CreateFileReferences {
  void call({
    required String packageName,
    required List<String> filePaths,
    required String tempFilePath,
  }) {
    final fileReferences = [
      '// ignore_for_file: unused_import', // Ignore unused imports, they're just used for referencing untested files
      ...filePaths
          .map((filePath) => filePath
              .replaceFirst('lib', '') // Remove `lib` from file path
              .replaceAll('\\', '/'))
          .map(
            (filePath) =>
                "import 'package:$packageName$filePath';", // Add import for file
          ),
      'void main(){ /* No-op */ }',
    ].join('\n');

    if (!_doesFileExist(tempFilePath)) {
      _createFile(tempFilePath);
    }

    _writeToFile(fileReferences, tempFilePath);
  }

  bool _doesFileExist(String path) => File(path).existsSync();

  void _createFile(String path) => File(path).createSync(recursive: true);

  void _writeToFile(String content, String path) =>
      File(path).writeAsStringSync(content);
}
