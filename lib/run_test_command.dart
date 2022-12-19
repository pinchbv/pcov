import 'dart:async';
import 'dart:io';

class RunTestCommand {
  Future<void> call({
    required String command,
  }) async {
    final completer = Completer();
    final commandSplitted = command.split(' ');
    final executable = commandSplitted.first;
    final arguments = commandSplitted
        .getRange(1, commandSplitted.length)
        .toList(growable: false);

    final process = await Process.start(executable, arguments);
    process.stdout.listen(
      stdout.add,
      onDone: () async => completer.complete(await process.exitCode),
    );

    final int exitCode = await completer.future;
    if (exitCode != 0) {
      stderr.write('Running `$command` failed with exit code $exitCode.\n');
      exit(exitCode);
    }
  }
}
