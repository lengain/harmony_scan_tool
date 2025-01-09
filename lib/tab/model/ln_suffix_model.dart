import 'package:json_annotation/json_annotation.dart';

import '../../util/mn_global_util.dart';
import 'ln_display_model.dart';
import 'ln_file_info_model.dart';

part 'ln_suffix_model.g.dart'; // 这行是告诉生成器将生成的代码放在这个文件中

@JsonSerializable()
class LNSuffixModel extends LNDisplayModel {
  String param;
  List<String> pathList;
  String startTime;
  String stopTime;
  String taskDesc;
  int taskType;
  List<LNFileInfoModel> result;

  LNSuffixModel(this.param, this.pathList, this.startTime, this.stopTime,
      this.taskDesc, this.taskType, this.result);

  // 从JSON生成User对象
  factory LNSuffixModel.fromJson(Map<String, dynamic> json) =>
      _$LNSuffixModelFromJson(json);

  // 将User对象转换为JSON
  Map<String, dynamic> toJson() => _$LNSuffixModelToJson(this);

  @override
  Map<String, dynamic> toTreeJson() {
    Map<String, dynamic> treeMap = {};
    for (var info in result) {
      final String title =
          ".${info.suffix} ${MNGlobalUtil.formatBytes(info.totalSize)}";
      Map<String, dynamic> infoMap = {};
      for (var file in info.files) {
        final String fileTitle =
            "${file.file} ${MNGlobalUtil.formatBytes(file.size)}";
        infoMap[fileTitle] = {};
      }
      treeMap[title] = infoMap;
    }

    return treeMap;
  }
}
