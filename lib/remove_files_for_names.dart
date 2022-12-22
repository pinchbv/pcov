import 'dart:io';

/// Removes files based on file name
class RemoveFilesForNames {
  /// Removes filePaths of files with any name given in [fileNamesToExclude].
  List<String> call({
    required List<String> filePaths,
    required List<String> fileNamesToExclude,
  }) {
    final mutableFilePaths = List<String>.from(filePaths);

    final fileNamePatterns = fileNamesToExclude
        .map((pattern) => pattern.replaceAll('.', '\\.')) // Escape dots
        .map((pattern) => pattern.replaceAll('*', r'.*'))
        .map((pattern) => RegExp(pattern))
        .toList(growable: false);

    mutableFilePaths.removeWhere((filePath) => _containsFileName(
          file: File(filePath),
          patterns: fileNamePatterns,
        ));

    return mutableFilePaths;
  }

  bool _containsFileName({
    required File file,
    required List<RegExp> patterns,
  }) {
    final fileName = file.uri.pathSegments.last;
    final hasMatch = patterns.any((RegExp regEx) => regEx.hasMatch(fileName));
    return hasMatch;
  }
}
