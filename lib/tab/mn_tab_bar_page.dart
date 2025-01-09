import 'package:flutter/material.dart';

import '/tab/mn_detail_page.dart';
import '/tab/model/ln_tab_model.dart';
import '../root/mn_page_controller.dart';
import 'mn_duplicate_page.dart';
import 'widget/ln_tab_bar.dart';

class MNTabBarPage extends StatefulWidget {
  final VoidCallback onBackAction;

  const MNTabBarPage(
      {super.key, required this.title, required this.onBackAction});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MNTabBarPage> createState() => _MNTabBarPagePageState();
}

class _MNTabBarPagePageState extends State<MNTabBarPage> {
  final PageController _controller = PageController(initialPage: 0);
  int _selectedIndex = 0;
  final List<LNTabModel> _tabBarList = [
    LNTabModel('文件大小', Icons.file_copy_sharp, Icons.file_copy_sharp),
    LNTabModel('重复文件', Icons.repeat_one, Icons.repeat_one),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DividerThemeData dividerTheme = DividerTheme.of(context);

    return Row(
      children: [
        // 侧边栏
        Container(
          color: const Color.fromRGBO(235, 230, 228, 1),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LNTabBar(
                tabBarList: _tabBarList,
                onTabSelected: (int value) {
                  setState(() {
                    _selectedIndex = value;
                    _controller.jumpToPage(value);
                  });
                },
              ),
              GestureDetector(
                onTap: () => {widget.onBackAction()},
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.fromLTRB(10, 0, 16, 16),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.black54,
                          size: 18,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: Text(
                            '返回',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        // 内容区域，占据剩余空间
        Expanded(
          child: PageView(
            controller: _controller,
            children: [
              Material(
                  child: LNDetailPage(
                tabModel: _tabBarList[_selectedIndex],
                displayData: MNPageController.share().suffixData,
              )),
              Material(
                  child: MNDuplicatePage(
                tabModel: _tabBarList[_selectedIndex],
                displayList: MNPageController.share().duplicateList,
              )),
            ],
          ),
        )
      ],
    );
  }
}
