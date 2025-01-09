// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ln_file_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LNFileInfoModel _$LNFileInfoModelFromJson(Map<String, dynamic> json) =>
    LNFileInfoModel(
      files: (json['files'] as List<dynamic>)
          .map((e) => LNFileItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      suffix: json['suffix'] as String,
      totalSize: (json['totalSize'] as num).toInt(),
    );

Map<String, dynamic> _$LNFileInfoModelToJson(LNFileInfoModel instance) =>
    <String, dynamic>{
      'files': instance.files,
      'suffix': instance.suffix,
      'totalSize': instance.totalSize,
    };
