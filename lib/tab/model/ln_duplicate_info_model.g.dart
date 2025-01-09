// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ln_duplicate_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LNDuplicateInfoModel _$LNDuplicateInfoModelFromJson(
        Map<String, dynamic> json) =>
    LNDuplicateInfoModel(
      files: (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      md5: json['md5'] as String,
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$LNDuplicateInfoModelToJson(
        LNDuplicateInfoModel instance) =>
    <String, dynamic>{
      'files': instance.files,
      'md5': instance.md5,
      'size': instance.size,
    };
