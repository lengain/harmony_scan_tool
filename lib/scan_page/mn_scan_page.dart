import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../command/mn_command_line.dart';
import '../localizations/ln_localizations.dart';
import '../root/mn_page_controller.dart';
import '../util/environment.dart';
import '../util/file_util.dart';
import '../util/mn_alert_util.dart';
import '../util/mn_native_manager.dart';

class MNScanPage extends StatefulWidget {
  final VoidCallback onAnalyzeFinish;

  const MNScanPage({super.key, required this.onAnalyzeFinish});

  @override
  State<StatefulWidget> createState() {
    return _MNScanPageState();
  }
}

class _MNScanPageState extends State<MNScanPage> {
  String _openJdkVersion = 'OpenJDK Unknown Version';
  String _studioVersion = 'Unknown';
  String _filePath = '';
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    MNPageController.share().dragInputFilePath = (String filePath) {
      refreshFilePath(filePath);
    };
    macEnvironmentCheck();
  }



  macEnvironmentCheck() {
    MNCommandLine.openJdkVersionFromPlugin((String version) {
      setState(() {
        _openJdkVersion = version;
      });
    });

    setState(() {
      _studioVersion = Environment.devEcoStudioVersion();
    });
  }

  Future<void> selectFilePath() async {
    String filePath;
    try {
      filePath = await MNNativeManager.share().bridge.selectFilePath() ??
          'Unknown platform version';
    } on PlatformException {
      filePath = 'Failed to get file path.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    refreshFilePath(filePath);
  }

  refreshFilePath(String filePath) {
    setState(() {
      _filePath = filePath;
      textController.text = filePath;
    });
  }

  startAnalyse(BuildContext context) {
    MNPageController.share().analysisState = MNAnalysisState.before;
    bool fileExist = FileUtil.fileExistsSync(_filePath);
    print('app filt is exist : $fileExist');
    if (!fileExist) {
      MNAlert.showMacosAlert(context, "温馨提示", "请输入文件路径");
      return;
    }
    context.loaderOverlay.show();
    MNCommandLine.suffixAnalyse(_filePath, () {
      MNCommandLine.duplicateAnalyse(_filePath, () {
        context.loaderOverlay.hide();
        widget.onAnalyzeFinish();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                width: 400,
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    labelText: '输入鸿蒙App文件路径（.app）',
                  ),
                  onEditingComplete: () async {
                    // Optionally handle editing complete
                  },
                  onChanged: (value) {
                    // Handle text changes
                  },
                )),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  selectFilePath();
                },
                child: const Icon(Icons.file_open_outlined)),
          ]),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              startAnalyse(context);
            },
            child: Text(
              LNLocalizations.of(context).startAnalytics,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _openJdkVersion,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _studioVersion,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 140),
        ],
      )),
    );
  }
}
