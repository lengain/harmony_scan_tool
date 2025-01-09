import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:path_drawing/path_drawing.dart';

import '/tab/model/ln_tab_model.dart';
import '/tab/model/ln_tree_data.dart';
import '/tab/widget/ln_expand_icon.dart';
import '../third_lib/ln_tree_lib.dart';

class LNDetailPage extends StatefulWidget {
  final LNTabModel tabModel;

  final Map displayData;

  const LNDetailPage(
      {super.key, required this.tabModel, required this.displayData});

  @override
  State<StatefulWidget> createState() {
    return _LNDetailPageState();
  }
}

class _LNDetailPageState extends State<LNDetailPage> {
  late final TreeController<Node> treeController;
  late final Node root = Node(title: '/');

  @override
  void initState() {
    super.initState();

    LNTreeData.generateTreeNodes(widget.displayData, root, (parent, title) {
      final child = Node(title: title);
      parent.children.add(child);
      return child;
    });
    treeController = TreeController<Node>(
      roots: root.children,
      childrenProvider: (Node node) => node.children,
    );
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TreeIndentGuideScope(
        child: AnimatedTreeView<Node>(
      treeController: treeController,
      nodeBuilder: (BuildContext context, TreeEntry<Node> entry) {
        return TreeIndentation(
          entry: entry,
          child: Row(
            children: [
              if (entry.hasChildren)
                LNExpandIcon(
                  key: GlobalObjectKey(entry.node),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  isExpanded: entry.isExpanded,
                  onPressed: (_) => treeController.toggleExpansion(entry.node),
                )
              else
                const SizedBox(height: 40, width: 8),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SelectableText(
                      entry.node.title,
                      style: TextStyle(
                          fontWeight: entry.node.isBold()
                              ? FontWeight.bold
                              : FontWeight.normal),
                    )),
                    if (entry.node.size.isNotEmpty)
                      Text(
                        entry.node.size,
                        style: TextStyle(
                            fontWeight: entry.node.isBold()
                                ? FontWeight.bold
                                : FontWeight.normal),
                      )
                    else
                      const SizedBox(height: 40, width: 8),
                    const SizedBox(height: 40, width: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      duration: Duration.zero, //const Duration(milliseconds: 300)
    ));
  }
}

class TreeIndentGuideScope extends StatelessWidget {
  const TreeIndentGuideScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const IndentGuideType guideType = IndentGuideType.connectingLines;
    final IndentGuide guide;
    const SettingsState state = SettingsState();
    switch (guideType) {
      case IndentGuideType.connectingLines:
        guide = IndentGuide.connectingLines(
          indent: state.indent,
          color: Theme.of(context).colorScheme.outline,
          thickness: state.lineThickness,
          origin: state.lineOrigin,
          strokeCap: StrokeCap.round,
          pathModifier: getPathModifierFor(state.lineStyle),
          roundCorners: state.roundedCorners,
          connectBranches: state.connectBranches,
        );
        break;
      case IndentGuideType.scopingLines:
        guide = IndentGuide.scopingLines(
          indent: state.indent,
          color: Theme.of(context).colorScheme.outline,
          thickness: state.lineThickness,
          origin: state.lineOrigin,
          strokeCap: StrokeCap.round,
          pathModifier: getPathModifierFor(state.lineStyle),
        );
        break;
      case IndentGuideType.blank:
        guide = IndentGuide(indent: state.indent);
        break;
    }

    return DefaultIndentGuide(
      guide: guide,
      child: child,
    );
  }

  Path Function(Path)? getPathModifierFor(LineStyle lineStyle) {
    return switch (lineStyle) {
      LineStyle.dashed => (Path path) => dashPath(
            path,
            dashArray: CircularIntervalList(const [6, 4]),
            dashOffset: const DashOffset.absolute(6 / 4),
          ),
      LineStyle.dotted => (Path path) => dashPath(
            path,
            dashArray: CircularIntervalList(const [0.5, 3.5]),
            dashOffset: const DashOffset.absolute(0.5 * 3.5),
          ),
      LineStyle.solid => null,
    };
  }
}
