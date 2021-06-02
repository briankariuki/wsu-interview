// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse()
    ..token = json['token'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..error = json['error'] == null
        ? null
        : Error.fromJson(json['error'] as Map<String, dynamic>)
    ..entry = json['entry'] == null
        ? null
        : Entry.fromJson(json['entry'] as Map<String, dynamic>)
    ..entryPage = json['entryPage'] == null
        ? null
        : EntryPage.fromJson(json['entryPage'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
      'error': instance.error,
      'entry': instance.entry,
      'entryPage': instance.entryPage,
    };
