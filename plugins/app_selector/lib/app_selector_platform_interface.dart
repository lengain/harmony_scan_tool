import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_selector_method_channel.dart';

abstract class AppSelectorPlatform extends PlatformInterface {
  /// Constructs a AppSelectorPlatform.
  AppSelectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppSelectorPlatform _instance = MethodChannelAppSelector();

  /// The default instance of [AppSelectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppSelector].
  static AppSelectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppSelectorPlatform] when
  /// they register themselves.
  static set instance(AppSelectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> selectFilePath() {
    throw UnimplementedError('selectFilePath() has not been implemented.');
  }

  Future<void> setRootPageType(int type) {
    throw UnimplementedError('setRootPageType() has not been implemented.');
  }
}
