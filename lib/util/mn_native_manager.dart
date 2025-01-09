import 'package:app_selector/app_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '/root/mn_page_controller.dart';
import '../root/mn_root_page.dart';

class MNNativeManager {
  // 私有构造函数，防止外部实例化
  MNNativeManager._();

  // 静态变量持有类的唯一实例
  static dynamic _instance;

  // 提供一个静态的获取方法
  static MNNativeManager share() {
    _instance ??= MNNativeManager._();
    return _instance;
  }

  //发送
  final bridge = AppSelector();

  // 监听
  static const platform = MethodChannel('com.lengain.htool');

  void config() {
    platform.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'isSelectingAppPath':
        return MNPageController.share().pageType == MNRootPageType.scan;
      case 'performDragPath':
        var filePath = call.arguments;
        if (MNPageController.share().dragInputFilePath != null) {
          MNPageController.share().dragInputFilePath!(filePath);
        }
      default:
        if (kDebugMode) {
          print('Unknown method ${call.method}');
        }
    }
  }
}
