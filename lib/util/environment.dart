import 'dart:convert';
import 'dart:io';

import '/util/file_util.dart';

class Environment {
  static String devEcoStudioVersion() {
    const String studioPath =
        '/Applications/DevEco-Studio.app/Contents/Info.plist';
    const String productInfo =
        '/Applications/DevEco-Studio.app/Contents/Resources/product-info.json';
    String version = '';
    if (FileUtil.fileExistsSync(studioPath) == true) {
      Map<dynamic, dynamic> infoStudio = FileUtil.readPlistAsMap(studioPath);
      dynamic short = infoStudio['CFBundleShortVersionString'];
      version += 'DevEco Studio ';
      version += short.toString();
    } else {
      return "DevEco-Studio未安装";
    }
    if (FileUtil.fileExistsSync(productInfo)) {
      final file = File(productInfo);
      final jsonString = file.readAsStringSync();
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      dynamic short = jsonMap['version'];
      version += ', Build Version:';
      version += short.toString();
    }
    return version;
  }
}
