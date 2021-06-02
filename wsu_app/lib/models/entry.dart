import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:wsu_app/helpers/helpers.dart';
import 'package:wsu_app/models/user.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry extends BaseObject {
  User user;
  String county;
  String subcounty;
  List<String> animals;
  int animalsAffected;
  int animalsDead;
  String animalSymptoms;
  int peopleAffected;
  int peopleDead;
  String humanSymptoms;
  List<String> exposed;

  @JsonKey(ignore: true)
  bool self = false;

  static Entry fromJson(dynamic json) => _$EntryFromJson(json);

  static Entry fromString(String json) => _$EntryFromJson(jsonDecode(json));

  @override
  String toString() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => _$EntryToJson(this);
}
