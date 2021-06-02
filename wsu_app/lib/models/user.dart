import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:wsu_app/helpers/helpers.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseObject {
  String email;
  String displayName;
  String profileURL;

  @JsonKey(ignore: true)
  bool self = false;

  static User fromJson(dynamic json) => _$UserFromJson(json);

  static User fromString(String json) => _$UserFromJson(jsonDecode(json));

  @override
  String toString() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
