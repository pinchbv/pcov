import 'dart:io';

class RemoveFilesForContent {
  List<String> call({
    required List<String> filePaths,
    required List<String> fileContentToExclude,
  }) {
    final mutableFilePaths = List<String>.from(filePaths);

    final contentPatterns = fileContentToExclude
        .map((pattern) => pattern.replaceAll('*', r'[\S\s]*')) // Convert * to regex wildcard pattern
        .map((pattern) => RegExp(pattern)) // Map to RegExp objects
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
