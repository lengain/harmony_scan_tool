import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_selector_platform_interface.dart';

/// An implementation of [AppSelectorPlatform] that uses method channels.
class MethodChannelAppSelector extends AppSelectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_selector');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> selectFilePath() async {
    final version = await methodChannel.invokeMethod<String>('selectFilePath');
    return version;
  }

  @override
  Future<String?> javaVersion() async {
    final version = await methodChannel.invokeMethod<String>('javaVersion');
    return version;
  }

  @override
  Future<void> setRootPageType(int type) async {
    return await methodChannel.invokeMethod<void>('setRootPageType', [type]);
  }
}
