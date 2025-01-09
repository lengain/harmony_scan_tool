class LNTreeData {
  static void generateTreeNodes<T>(
      Map treeData, T root, T Function(T, String) addNewChild) {
    void traverse(T node, Map map) {
      for (final MapEntry(:key, :value) in map.entries) {
        final child = addNewChild(node, key);
        traverse(child, value);
      }
    }

    traverse(root, treeData);
  }
}
