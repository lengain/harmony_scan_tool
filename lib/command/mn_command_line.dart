import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '/tab/model/ln_duplicate_model.dart';
import '../root/mn_page_controller.dart';
import '../tab/model/ln_suffix_model.dart';
import '../util/file_util.dart';
import '../util/mn_string_util.dart';

class MNCommandLine {
  static Future<bool> runCommand(String command, List<String> arguments) async {
    final process = await Process.run(command, arguments);
    if (process.exitCode == 0) {
      print('Command executed successfully: ${process.stdout}');
      return true;
    } else {
      print(
          'Command failed with exit code ${process.exitCode}: ${process.stderr}');
      return false;
    }
  }

  static suffixAnalyse(String filePath, VoidCallback complete) {
    MNCommandLine.startAnalyse("--stat-suffix", filePath, (bool success) async {
      if (success) {
        MNPageController.share().analysisState = MNAnalysisState.analysed;
        String filePath =
            p.join(MNPageController.share().outputPath, "stat.json");
        if (FileUtil.fileExistsSync(filePath)) {
          final jsonMap = await FileUtil.readJsonAsMap(filePath);
          final model = LNSuffixModel.fromJson(jsonMap);
          MNPageController.share().suffixData = model.toTreeJson();
        }
      }
      complete();
    });
  }

  static duplicateAnalyse(String filePath, VoidCallback complete) {
    MNCommandLine.startAnalyse("--stat-duplicate", filePath,
        (bool success) async {
      if (success) {
        MNPageController.share().analysisState = MNAnalysisState.analysed;
        String filePath =
            p.join(MNPageController.share().outputPath, "stat.json");
        if (FileUtil.fileExistsSync(filePath)) {
          final jsonMap = await FileUtil.readJsonAsMap(filePath);
          final model = LNDuplicateModel.fromJson(jsonMap);
          MNPageController.share().duplicateList = model.toDuplicateList();
        }
      }
      complete();
    });
  }

  static startAnalyse(
      String command, String filePath, void Function(bool success) complete) {
    const String jarPath =
        "/Applications/DevEco-Studio.app/Contents/sdk/default/openharmony/toolchains/lib/app_check_tool.jar";
    String outPath = FileUtil.outputPath(filePath);
    MNPageController.share().outputPath = outPath;
    List<String> parameters = [
      '-jar',
      jarPath,
      '--input',
      filePath,
      '--out-path',
      outPath,
      command,
      'true'
    ];
    bool jarExist = FileUtil.fileExistsSync(jarPath);
    print('jar is exist : $jarExist');

    bool outPutPathExist = FileUtil.directoryExistsSync(outPath);
    if (kDebugMode) {
      print('outPath = $outPath');
      print('out  put Path is exist : $outPutPathExist');
    }
    MNPageController.share().analysisState = MNAnalysisState.analysing;
    MNCommandLine.runCommand('java', parameters).then((bool success) async {
      complete(success);
    });
  }

  static checkJavaInstalled(void Function(bool install) callBack) async {
    final process = await Process.run('java', ['--version']);
    if (process.exitCode == 0) {
      print('Command executed successfully: ${process.stdout}');

      // 正则表达式匹配 OpenJDK 版本号（假设版本号的格式为 x.y.z）
      RegExp versionRegex = RegExp(r'openjdk\s+(\d+\.\d+\.\d+)');
      RegExpMatch? match = versionRegex.firstMatch(process.stdout);

      if (match != null && match.groupCount >= 1) {
        String openjdkVersion = match.group(1)!;
        if (MNStringUtil.compareVersions(openjdkVersion, "1.0.0") >= 0) {
          callBack(true);
        } else {
          callBack(false);
        }
        print('OpenJDK Version: $openjdkVersion');
      } else {
        // 正则表达式匹配 OpenJDK 版本号（假设版本号的格式为 x.y.z）
        RegExp versionRegex = RegExp(r'java\s+(\d+\.\d+\.\d+)');
        RegExpMatch? match = versionRegex.firstMatch(process.stdout);
        if (match != null && match.groupCount >= 1) {
          String openjdkVersion = match.group(1)!;
          if (MNStringUtil.compareVersions(openjdkVersion, "1.0.0") >= 0) {
            callBack(true);
          } else {
            callBack(false);
          }
          print('OpenJDK Version: $openjdkVersion');
        } else {
          print('No OpenJDK version found.');
        }
      }
    } else {
      callBack(false);
      print(
          'Command failed with exit code ${process.exitCode}: ${process.stderr}');
    }
  }

  static openJdkVersion(void Function(String version) callBack) async {
    final process = await Process.run('java', ['--version']);
    if (process.exitCode == 0) {
      var stdout = process.stdout;
      if (kDebugMode) {
        print('Command executed successfully: $stdout');
      }
      // 正则表达式匹配 OpenJDK 版本号（假设版本号的格式为 x.y.z）
      RegExp versionRegex =
          RegExp(r'(?:\bopenjdk\b|\bjava\b)\s+(\d+\.\d+\.\d+)');
      RegExpMatch? match = versionRegex.firstMatch(stdout);
      if (match != null && match.groupCount >= 1) {
        String openjdkVersion = match.group(1)!;
        callBack('OpenJDK: $openjdkVersion');
        print('OpenJDK Version: $openjdkVersion');
      } else {
        callBack('No Java version found. Please Install Java JDK');
      }
    } else {
      callBack(
          'Command failed with exit code ${process.exitCode}: ${process.stderr}');
    }
  }
}
