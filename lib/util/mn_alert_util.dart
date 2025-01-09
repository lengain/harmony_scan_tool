import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class MNAlert {
  static showMacosAlert(BuildContext context, String title, String message) {
    showMacosAlertDialog(
      context: context,
      builder: (_) => MacosAlertDialog(
        appIcon: const FlutterLogo(size: 64),
        title: Text(
          title,
          style: MacosTheme.of(context).typography.headline,
        ),
        message: Text(
          message,
          textAlign: TextAlign.center,
          style: MacosTypography.of(context).headline,
        ),
        primaryButton: PushButton(
          controlSize: ControlSize.large,
          child: const Text('确定'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  static showCupertinoAlertDialog(
      BuildContext context, String title, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            // CupertinoDialogAction(
            //   isDefaultAction: true,
            //   child: Text('取消'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () {
                // 处理确定按钮点击事件
                Navigator.of(context).pop();
                // 可以在这里添加其他逻辑
              },
            ),
          ],
        );
      },
    );
  }
}
