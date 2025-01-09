import 'package:json_annotation/json_annotation.dart';

import '../../util/mn_global_util.dart';
import 'ln_display_model.dart';
import 'ln_duplicate_display_model.dart';
import 'ln_duplicate_info_model.dart';

part 'ln_duplicate_model.g.dart'; // 这行是告诉生成器将生成的代码放在这个文件中

@JsonSerializable()
class LNDuplicateModel extends LNDisplayModel {
  String param;
  String startTime;
  String stopTime;
  String taskDesc;
  int taskType;
  List<LNDuplicateInfoModel> result;

  LNDuplicateModel(this.param, this.startTime, this.stopTime, this.taskDesc,
      this.taskType, this.result);

  // 从JSON生成User对象
  factory LNDuplicateModel.fromJson(Map<String, dynamic> json) =>
      _$LNDuplicateModelFromJson(json);

  // 将User对象转换为JSON
  Map<String, dynamic> toJson() => _$LNDuplicateModelToJson(this);

  @override
  Map<String, dynamic> toTreeJson() {
    Map<String, dynamic> treeMap = {};
    for (var info in result) {
      for (var deprecatedFile in info.files) {
        final String title =
            ".$deprecatedFile ${MNGlobalUtil.formatBytes(info.size)}";
        treeMap[title] = {};
      }
    }
    return treeMap;
  }

  List<LNDuplicateDisplayModel> toDuplicateList() {
    List<LNDuplicateDisplayModel> dataList = [];
    for (var info in result) {
      for (var deprecatedFile in info.files) {
        var model = LNDuplicateDisplayModel(
            deprecatedFile, MNGlobalUtil.formatBytes(info.size));
        dataList.add(model);
      }
    }
    return dataList;
  }
}
