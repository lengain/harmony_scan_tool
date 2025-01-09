import 'package:json_annotation/json_annotation.dart';

part 'ln_duplicate_info_model.g.dart';

@JsonSerializable()
class LNDuplicateInfoModel {
  List<String> files;
  String md5;
  int size;

  LNDuplicateInfoModel(
      {required this.files, required this.md5, required this.size});

  factory LNDuplicateInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LNDuplicateInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$LNDuplicateInfoModelToJson(this);
}
