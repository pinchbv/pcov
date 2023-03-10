import 'dart:io';

import 'package:pcov/pcov_configuration.dart';
import 'package:yaml/yaml.dart';

/// Gets the Pcov configuration
class GetPcovConfiguration {
  static const _excludeKey = 'exclude';
  static const _fileNameKey = 'file_name';
  static const _contentKey = 'content';

  /// Returns a [PcovConfiguration] for the configuration defined in the [configurationFilePath]
  PcovConfiguration call({
    String configurationFilePath = 'pcov.yaml',
  }) {
    final fileNamesToExclude = <String>[];
    final fileContentToExclude = <String>[];
    final pcovConfigurationFile = File(configurationFilePath);

    if (pcovConfigurationFile.existsSync()) {
      final pcovYamlContent = pcovConfigurationFile.readAsStringSync();
      final YamlMap configuration = loadYaml(pcovYamlContent);
      if (configuration.containsKey(_excludeKey)) {
        final YamlMap excludes = configuration[_excludeKey];

        // Check for file names and remove if needed
        if (excludes.containsKey(_fileNameKey)) {
          final fileNamesFromYaml = excludes[_fileNameKey];
          fileNamesToExclude.addAll(List<String>.from(fileNamesFromYaml));
        }

        // Check for file content and remove if needed
        if (excludes.containsKey(_contentKey)) {
          final contentFromYaml = excludes[_contentKey];
          fileContentToExclude.addAll(List<String>.from(contentFromYaml));
        }
      }
    }

    return PcovConfiguration(
      fileNamesToExclude: fileNamesToExclude,
      fileContentToExclude: fileContentToExclude,
    );
  }
}
