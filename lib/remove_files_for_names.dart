import 'dart:io';

class RemoveFilesForNames {
  List<String> call({
    required List<String> filePaths,
    required List<String> fileNamesToExclude,
  }) {
    final mutableFilePaths = List<String>.from(filePaths);

    final fileNamePatterns = fileNamesToExclude
        .map((pattern) => pattern.replaceAll('.', '\\.')) // Escape dots
        .map((pattern) => pattern.replaceAll('*', r'.*')) // Convert * to regex wildcard pattern
        .map((pattern) => RegExp(pattern)) // Map to RegExp objects
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
