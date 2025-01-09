import 'package:flutter/material.dart';

import '../scan_page/mn_scan_page.dart';
import '../tab/mn_tab_bar_page.dart';
import '../util/mn_native_manager.dart';

enum MNRootPageType { scan, detail }

class MNRootPage extends StatefulWidget {
  const MNRootPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MNRootPageState();
  }
}

class _MNRootPageState extends State<MNRootPage> {
  @override
  void initState() {
    super.initState();
    MNNativeManager.share().config();
  }

  MNRootPageType _pageType = MNRootPageType.scan;

  void changePageType(MNRootPageType pageType) {
    setState(() {
      _pageType = pageType;
      MNNativeManager.share().bridge.setRootPageType(pageType.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _pageType == MNRootPageType.scan
          ? MNScanPage(
              onAnalyzeFinish: () {
                changePageType(MNRootPageType.detail);
              },
            )
          : MNTabBarPage(
              title: 'Flutter Demo Home Page',
              onBackAction: () {
                changePageType(MNRootPageType.scan);
              },
            ),
    );
  }
}
