// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ln_file_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LNFileItemModel _$LNFileItemModelFromJson(Map<String, dynamic> json) =>
    LNFileItemModel(
      json['file'] as String,
      (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$LNFileItemModelToJson(LNFileItemModel instance) =>
    <String, dynamic>{
      'file': instance.file,
      'size': instance.size,
    };
