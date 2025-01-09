import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:plist_parser/plist_parser.dart';

class FileUtil {
  static Future<bool> fileExists(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

  static Future<bool> directoryExists(String directoryPath) async {
    final directory = Directory(directoryPath);
    return await directory.exists();
  }

  static bool fileExistsSync(String filePath) {
    final file = File(filePath);
    return file.existsSync();
  }

  static bool directoryExistsSync(String directoryPath) {
    final directory = Directory(directoryPath);
    return directory.existsSync();
  }

  static Map readPlistAsMap(String plistPath) {
    return PlistParser().parseFileSync(plistPath);
  }

  static String outputPath(String appFilePath) {
    String fileName = p.basenameWithoutExtension(appFilePath);
    String outputPath = p.join(Directory.systemTemp.path, fileName);
    final directory = Directory(outputPath);
    final exist = directory.existsSync();
    if (!exist) {
      directory.create();
    }
    return outputPath;
  }

  static Future<Map<String, dynamic>> readJsonAsMap(String filePath) async {
    final file = File(filePath);
    final jsonString = await file.readAsString();
    final jsonArray = jsonDecode(jsonString) as List<dynamic>;
    return jsonArray[0] as Map<String, dynamic>;
  }
}
