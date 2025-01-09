// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ln_suffix_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LNSuffixModel _$LNSuffixModelFromJson(Map<String, dynamic> json) =>
    LNSuffixModel(
      json['param'] as String,
      (json['pathList'] as List<dynamic>).map((e) => e as String).toList(),
      json['startTime'] as String,
      json['stopTime'] as String,
      json['taskDesc'] as String,
      (json['taskType'] as num).toInt(),
      (json['result'] as List<dynamic>)
          .map((e) => LNFileInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LNSuffixModelToJson(LNSuffixModel instance) =>
    <String, dynamic>{
      'param': instance.param,
      'pathList': instance.pathList,
      'startTime': instance.startTime,
      'stopTime': instance.stopTime,
      'taskDesc': instance.taskDesc,
      'taskType': instance.taskType,
      'result': instance.result,
    };
