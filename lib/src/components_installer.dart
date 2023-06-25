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
      Logger().success('- $componentName installed', onlyVerbose: true);
    } else {
      Logger().error('- $componentName no installed');
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
    if (Platform.isMacOS || Platform.isLinux) {
      final brewPath = await _getBrewPath();
      final processResult = await Process.run(
        "bash",
        ["-c", "$brewPath install $componentName"],
      );
      return processResult.exitCode == 0;
    }
    throw UnimplementedError();
  }

  Future<bool> _isInstalledComponent(String componentName) async {
    if (Platform.isMacOS || Platform.isLinux) {
      final brewPath = await _getBrewPath();
      final processResult = await Process.run(
        "bash",
        ["-c", "$brewPath list | grep $componentName"],
      );
      return (processResult.stdout as String).isNotEmpty;
    }
    throw UnimplementedError();
  }

  Future<void> _checkPackageManager() async {
    Logger().info('Package manager:', onlyVerbose: true);
    if (Platform.isMacOS || Platform.isLinux) {
      await _checkHomebrew();
    }
  }

  Future<bool> _checkHomebrew() async {
    final pathToBrew = await _getBrewPath();
    final isInstalled = pathToBrew != null;
    if (!isInstalled) {
      throw Exception('You don\'t have brew. Install url: https://brew.sh/');
    } else {
      Logger().success('- Homebrew installed', onlyVerbose: true);
    }
    return isInstalled;
  }

  Future<String?> _getBrewPath() async {
    final paths = [
      '/opt/homebrew/bin/brew',
      if (Platform.isLinux) '/home/linuxbrew/.linuxbrew/bin/brew',
    ];
    for (final path in paths) {
      if (await File(path).exists()) {
        return path;
      }
    }
    return null;
  }
}
