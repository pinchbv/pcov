import 'package:collection/collection.dart';

class PcovConfiguration {
  final List<String> fileNamesToExclude;
  final List<String> fileContentToExclude;

  const PcovConfiguration({
    required this.fileNamesToExclude,
    required this.fileContentToExclude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PcovConfiguration &&
          runtimeType == other.runtimeType &&
          ListEquality().equals(fileNamesToExclude, other.fileNamesToExclude) &&
          ListEquality()
              .equals(fileContentToExclude, other.fileContentToExclude);

  @override
  int get hashCode =>
      fileNamesToExclude.hashCode ^ fileContentToExclude.hashCode;
}
