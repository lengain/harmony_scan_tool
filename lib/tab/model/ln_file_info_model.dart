import 'package:json_annotation/json_annotation.dart';

import 'ln_file_item_model.dart';

part 'ln_file_info_model.g.dart';

@JsonSerializable()
class LNFileInfoModel {
  List<LNFileItemModel> files;
  String suffix;
  int totalSize;

  LNFileInfoModel(
      {required this.files, required this.suffix, required this.totalSize});

  factory LNFileInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LNFileInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$LNFileInfoModelToJson(this);
}
