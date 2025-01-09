import 'package:flutter/cupertino.dart';

class LNLocalizations {
  LNLocalizations(this.isZh);

  //是否为中文
  bool isZh = false;

  //为了使用方便，我们定义一个静态方法
  static LNLocalizations of(BuildContext context) {
    return Localizations.of<LNLocalizations>(context, LNLocalizations)!;
  }

  String get startAnalytics {
    return isZh ? "开始分析" : "Start Analytics";
  }
}
