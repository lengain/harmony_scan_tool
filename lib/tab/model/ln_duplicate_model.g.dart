// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ln_duplicate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LNDuplicateModel _$LNDuplicateModelFromJson(Map<String, dynamic> json) =>
    LNDuplicateModel(
      json['param'] as String,
      json['startTime'] as String,
      json['stopTime'] as String,
      json['taskDesc'] as String,
      (json['taskType'] as num).toInt(),
      (json['result'] as List<dynamic>)
          .map((e) => LNDuplicateInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LNDuplicateModelToJson(LNDuplicateModel instance) =>
    <String, dynamic>{
      'param': instance.param,
      'startTime': instance.startTime,
      'stopTime': instance.stopTime,
      'taskDesc': instance.taskDesc,
      'taskType': instance.taskType,
      'result': instance.result,
    };
