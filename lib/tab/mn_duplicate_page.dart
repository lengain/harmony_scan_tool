import 'package:flutter/material.dart';

import '/tab/model/ln_tab_model.dart';
import 'model/ln_duplicate_display_model.dart';

class MNDuplicatePage extends StatefulWidget {
  final LNTabModel tabModel;

  final List<LNDuplicateDisplayModel> displayList;

  const MNDuplicatePage(
      {super.key, required this.tabModel, required this.displayList});

  @override
  State<StatefulWidget> createState() {
    return _MNDuplicatePageState();
  }
}

class _MNDuplicatePageState extends State<MNDuplicatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.displayList.length,
        itemBuilder: (BuildContext context, int index) {
          var model = widget.displayList[index];
          // 注意：这里其实不需要 ~/，因为 / 对于整数已经足够
          // 但是为了明确表示是整数除法且截断，可以使用 ~/，它是 Dart 中的地板除法运算符
          int doubleIndex = index ~/ 2;
          return Flex(direction: Axis.horizontal, children: [
            Flexible(
              child: Container(
                height: 44,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                color: doubleIndex % 2 == 0
                    ? Colors.white
                    : const Color.fromRGBO(244, 244, 244, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SelectableText(
                      model.title,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    )),
                    Text(
                      model.size,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }
}
