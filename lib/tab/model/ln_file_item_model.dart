import 'package:json_annotation/json_annotation.dart';

part 'ln_file_item_model.g.dart';

@JsonSerializable()
class LNFileItemModel {
  String file;
  int size;

  LNFileItemModel(this.file, this.size);

  factory LNFileItemModel.fromJson(Map<String, dynamic> json) =>
      _$LNFileItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$LNFileItemModelToJson(this);
}
