import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'ln_localizations.dart';

class LNLocalizationsDelegate extends LocalizationsDelegate<LNLocalizations> {
  const LNLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<LNLocalizations> load(Locale locale) {
    print("$locale");
    return SynchronousFuture<LNLocalizations>(
        LNLocalizations(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(LNLocalizationsDelegate old) => false;
}
