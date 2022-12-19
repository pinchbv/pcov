import 'package:collection/collection.dart';
import 'package:pcov/get_dart_files.dart';
import 'package:pcov/get_pcov_configuration.dart';
import 'package:pcov/pcov_configuration.dart';
import 'package:pcov/remove_files_for_content.dart';
import 'package:pcov/remove_files_for_names.dart';
import 'package:test/test.dart';

void main() {
  test('Get all dart files from test/files folder', () {
    // Arrange
    final getDartFiles = GetDartFiles();
    final files = [
      'a.dart',
      'b.dart',
      'c.dart',
      'foo.dart',
      'foo.freezed.dart',
      'foo.g.dart',
      'foo_widget.dart',
      'widget.dart',
    ];

    // Act
    final dartFiles = getDartFiles(directory: './test/files');
    final dartFileNames = dartFiles.map((file) => file.uri.pathSegments.last).toList();

    // Assert
    expect(dartFileNames.length, files.length);
    for (final fileName in files) {
      expect(dartFileNames.contains(fileName), true);
    }
  });

  test('Parse pcov configuration yaml file', () {
    // Arrange
    final getPcovConfiguration = GetPcovConfiguration();
    final expectedConfiguration = PcovConfiguration(
      fileNamesToExclude: [
        '*.g.dart',
        '*.freezed.dart',
      ],
      fileContentToExclude: [
        'class * extends Widget *',
      ],
    );

    // Act
    final pcovConfiguration = getPcovConfiguration(configurationFilePath: './test/files/pcov.yaml');

    // Assert
    expect(pcovConfiguration, expectedConfiguration);
  });

  test('Remove file for filename', () {
    // Arrange
    final removeFilesForNames = RemoveFilesForNames();
    final fileNamesToExclude = ['*.g.dart'];
    final files = [
      'a.dart',
      'foo.dart',
      'foo.freezed.dart',
      'foo.g.dart',
      'foo_widget.dart',
    ];

    final expectedResult = [
      'a.dart',
      'foo.dart',
      'foo.freezed.dart',
      'foo_widget.dart',
    ];

    // Act
    final result = removeFilesForNames(
      filePaths: files,
      fileNamesToExclude: fileNamesToExclude,
    );

    // Assert
    expect(ListEquality().equals(result, expectedResult), true);
  });

  test('Remove file for content', () {
    // Arrange
    final removeFilesForNames = RemoveFilesForContent();
    final fileContentToExclude = ['class * extends Widget *'];
    final filesToTest = [
      './test/files/a.dart',
      './test/files/foo.g.dart',
      './test/files/foo_widget.dart',
    ];
    final expectedResult = [
      './test/files/a.dart',
      './test/files/foo.g.dart',
    ];

    // Act
    final result = removeFilesForNames(
      filePaths: filesToTest,
      fileContentToExclude: fileContentToExclude,
    );

    // Assert
    expect(ListEquality().equals(result, expectedResult), true);
  });
}
