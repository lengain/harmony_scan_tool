class MNStringUtil {
  static int compareVersions(String v1, String v2) {
    final parts1 = v1.split('.');
    final parts2 = v2.split('.');

    int i = 0;
    while (i < parts1.length && i < parts2.length) {
      final num1 = int.parse(parts1[i]);
      final num2 = int.parse(parts2[i]);

      if (num1 > num2) {
        return 1;
      } else if (num1 < num2) {
        return -1;
      }

      i++;
    }

    if (parts1.length > parts2.length) {
      return 1;
    } else if (parts1.length < parts2.length) {
      return -1;
    } else {
      return 0;
    }
  }
}
