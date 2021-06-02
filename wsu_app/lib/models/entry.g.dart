// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry()
    ..id = json['_id'] as String
    ..baseStatus = json['_status'] as String
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..county = json['county'] as String
    ..subcounty = json['subcounty'] as String
    ..animals = (json['animals'] as List)?.map((e) => e as String)?.toList()
    ..animalsAffected = json['animalsAffected'] as int
    ..animalsDead = json['animalsDead'] as int
    ..animalSymptoms = json['animalSymptoms'] as String
    ..peopleAffected = json['peopleAffected'] as int
    ..peopleDead = json['peopleDead'] as int
    ..humanSymptoms = json['humanSymptoms'] as String
    ..exposed = (json['exposed'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      '_id': instance.id,
      '_status': instance.baseStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
      'user': instance.user,
      'county': instance.county,
      'subcounty': instance.subcounty,
      'animals': instance.animals,
      'animalsAffected': instance.animalsAffected,
      'animalsDead': instance.animalsDead,
      'animalSymptoms': instance.animalSymptoms,
      'peopleAffected': instance.peopleAffected,
      'peopleDead': instance.peopleDead,
      'humanSymptoms': instance.humanSymptoms,
      'exposed': instance.exposed,
    };
