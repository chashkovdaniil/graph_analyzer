import 'dart:io';

import '../utils.dart';

class ComponentsInstaller {
  Future<void> checkComponents() async {
    Logger().info('Checking components...', onlyVerbose: true);
    await _checkPackageManager();
    Logger().info('Components:', onlyVerbose: true);
    await _checkComponent('graphviz');
    Logger().success('Checked', onlyVerbose: true);
  }

  Future<void> _checkComponent(String componentName) async {
    Logger().info('- $componentName', onlyVerbose: true);
    final isInstalled = await _isInstalledComponent(componentName);
    if (isInstalled) {
      Logger().success('- $componentName was installed', onlyVerbose: true);
    } else {
      Logger().error('- $componentName was no installed');
      Logger().regular('Do you want install $componentName? [y/n]');
      final answer = stdin.readLineSync();
      if (answer?.toLowerCase() == 'y') {
        final isInstalled = await _install(componentName);
        if (isInstalled) {
          Logger().success('$componentName was installed');
        } else {
          throw Exception('Error install $componentName');
        }
      }
    }
  }

  Future<bool> _install(String componentName) async {
    Logger().regular('Installing...');
    if (Platform.isMacOS) {
      final processResult = await Process.run(
        "bash",
        ["-c", "/opt/homebrew/bin/brew install $componentName"],
      );
      return processResult.exitCode == 0;
    }
    throw UnimplementedError();
  }

  Future<bool> _isInstalledComponent(String componentName) async {
    if (Platform.isMacOS) {
      final processResult = await Process.run(
        "bash",
        ["-c", "/opt/homebrew/bin/brew list | grep $componentName"],
      );
      return (processResult.stdout as String).isNotEmpty;
    }
    throw UnimplementedError();
  }

  Future<void> _checkPackageManager() async {
    Logger().info('Package manager:', onlyVerbose: true);
    if (Platform.isMacOS) {
      await _checkHomebrew();
    }
  }

  Future<bool> _checkHomebrew() async {
    final isInstalled = await Directory('/opt/homebrew/').exists();
    if (!isInstalled) {
      throw Exception('You don\'t have brew. Install url: https://brew.sh/');
    } else {
      Logger().success('- Homebrew installed', onlyVerbose: true);
    }
    return isInstalled;
  }
}
