import 'dart:io';

/// Removes files based on file content
class RemoveFilesForContent {
  /// Removes filePaths of files containing content of any given [fileContentToExclude] entries.
  List<String> call({
    required List<String> filePaths,
    required List<String> fileContentToExclude,
  }) {
    final mutableFilePaths = List<String>.from(filePaths);

    final contentPatterns = fileContentToExclude
        .map((pattern) => pattern.replaceAll('*', r'[\S\s]*'))
        .map((pattern) => RegExp(pattern))
        .toList(growable: false);

    mutableFilePaths.removeWhere((filePath) => _containsContent(
          file: File(filePath),
          patterns: contentPatterns,
        ));

    return mutableFilePaths;
  }

  bool _containsContent({
    required File file,
    required List<RegExp> patterns,
  }) {
    final content = file.readAsStringSync();
    final hasMatch = patterns.any((RegExp regEx) => regEx.hasMatch(content));
    return hasMatch;
  }
}
