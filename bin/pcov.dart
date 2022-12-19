import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:pcov/create_file_references.dart';
import 'package:pcov/get_dart_files.dart';
import 'package:pcov/get_package_name.dart';
import 'package:pcov/get_pcov_configuration.dart';
import 'package:pcov/remove_files_for_content.dart';
import 'package:pcov/remove_files_for_names.dart';
import 'package:pcov/run_test_command.dart';

const _tempFilePath = './test/pcov_test.dart';
const _testCommandKey = 'test-command';
const _defaultTestCommand = 'flutter test --coverage';

void main(List<String> arguments) {
  final parser = ArgParser();

  parser.addOption(
    _testCommandKey,
    defaultsTo: _defaultTestCommand,
    mandatory: false,
  );

  final argumentResults = parser.parse(arguments);
  final testCommand = argumentResults[_testCommandKey];

  _run(testCommand: testCommand);
}

Future<void> _run({
  required String testCommand,
}) async {
  // Get all dart files in lib folder
  final dartFiles = GetDartFiles().call();
  List<String> filePaths = dartFiles.map((file) => file.path).toList();

  // Get pcov configuration
  final configuration = GetPcovConfiguration().call();

  // Check for file names and remove if needed
  if (configuration.fileNamesToExclude.isNotEmpty) {
    filePaths = RemoveFilesForNames().call(
      filePaths: filePaths,
      fileNamesToExclude: configuration.fileNamesToExclude,
    );
  }

  // Check for file content and remove if needed
  if (configuration.fileContentToExclude.isNotEmpty) {
    filePaths = RemoveFilesForContent().call(
      filePaths: filePaths,
      fileContentToExclude: configuration.fileContentToExclude,
    );
  }

  // Create content for file in test folder that will reference all files as imports
  final packageName = GetPackageName().call();
  CreateFileReferences().call(packageName: packageName, filePaths: filePaths, tempFilePath: _tempFilePath);

  RunTestCommand().call(command: testCommand);

  // Delete temporary file references file
  _removeFile(_tempFilePath);
}

void _removeFile(String path) {
  final file = File(path);
  if (file.existsSync()) {
    file.deleteSync();
  }
}
