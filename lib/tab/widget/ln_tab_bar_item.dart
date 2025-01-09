import 'package:flutter/material.dart';

import '../model/ln_tab_model.dart';

class LNTabBarItem extends StatelessWidget {
  final bool isSelected;
  final LNTabModel model;

  const LNTabBarItem(
      {super.key, required this.isSelected, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color.fromRGBO(115, 159, 253, 1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(5), // 设置圆角半径为20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Icon(
              model.icon,
              size: 16,
              color: isSelected
                  ? Colors.white
                  : const Color.fromRGBO(70, 69, 68, 1),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              model.title,
              style: TextStyle(
                  fontSize: 13,
                  color: isSelected
                      ? Colors.white
                      : const Color.fromRGBO(70, 69, 68, 1),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
