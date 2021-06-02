import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:wsu_app/models/models.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  String token;

  User user;

  Error error;

  Entry entry;

  EntryPage entryPage;

  static BaseResponse fromJson(dynamic json) => _$BaseResponseFromJson(json);

  @override
  String toString() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
