import 'package:flutter/material.dart';

import '../model/ln_tab_model.dart';
import 'ln_tab_bar_item.dart';

class LNTabBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List<LNTabModel> tabBarList;

  const LNTabBar(
      {super.key, required this.onTabSelected, required this.tabBarList});

  @override
  LNTabBarState createState() => LNTabBarState();
}

class LNTabBarState extends State<LNTabBar> {
  int _selectedIndex = 0;
  late final List<LNTabModel> _tabList;

  @override
  void initState() {
    super.initState();
    _tabList = widget.tabBarList;
  }

  void onTabIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> tabBarChildren() {
    return _tabList
        .map((LNTabModel element) => GestureDetector(
              child: LNTabBarItem(
                isSelected: _selectedIndex == _tabList.indexOf(element),
                model: element,
              ),
              onTap: () {
                onTabIndex(_tabList.indexOf(element));
              },
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        //动态创建一个List<Widget>
        children: tabBarChildren(),
      ),
    );
  }
}
