import '../tab/model/ln_duplicate_display_model.dart';
import 'mn_root_page.dart';

enum MNAnalysisState {
  before,
  analysing,
  analysed,
}

class MNPageController {
  // 私有构造函数，防止外部实例化
  MNPageController._();

  // 静态变量持有类的唯一实例
  static dynamic _instance;

  // 提供一个静态的获取方法
  static MNPageController share() {
    _instance ??= MNPageController._();
    return _instance;
  }

  MNRootPageType pageType = MNRootPageType.scan;
  MNAnalysisState analysisState = MNAnalysisState.before;
  String outputPath = '';
  Map suffixData = {};
  Map duplicateData = {};
  List<LNDuplicateDisplayModel> duplicateList = [];
  void Function(String filePath)? dragInputFilePath;
}
