import 'package:app_selector/app_selector.dart';
import 'package:app_selector/app_selector_method_channel.dart';
import 'package:app_selector/app_selector_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppSelectorPlatform
    with MockPlatformInterfaceMixin
    implements AppSelectorPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> selectFilePath() {
    // TODO: implement selectFilePath
    throw UnimplementedError();
  }

  @override
  Future<void> setRootPageType(int type) {
    // TODO: implement setRootFileType
    throw UnimplementedError();
  }
}

void main() {
  final AppSelectorPlatform initialPlatform = AppSelectorPlatform.instance;

  test('$MethodChannelAppSelector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppSelector>());
  });

  test('getPlatformVersion', () async {
    AppSelector appSelectorPlugin = AppSelector();
    MockAppSelectorPlatform fakePlatform = MockAppSelectorPlatform();
    AppSelectorPlatform.instance = fakePlatform;

    expect(await appSelectorPlugin.getPlatformVersion(), '42');
  });
}
