// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['_id'] as String
    ..baseStatus = json['_status'] as String
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..email = json['email'] as String
    ..displayName = json['displayName'] as String
    ..profileURL = json['profileURL'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      '_status': instance.baseStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
      'email': instance.email,
      'displayName': instance.displayName,
      'profileURL': instance.profileURL,
    };
