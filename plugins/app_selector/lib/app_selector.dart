import 'app_selector_platform_interface.dart';

class AppSelector {
  Future<String?> getPlatformVersion() {
    return AppSelectorPlatform.instance.getPlatformVersion();
  }

  Future<String?> selectFilePath() {
    return AppSelectorPlatform.instance.selectFilePath();
  }

  Future<void> setRootPageType(int type) {
    return AppSelectorPlatform.instance.setRootPageType(type);
  }
}
