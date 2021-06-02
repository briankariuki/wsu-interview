import 'package:json_annotation/json_annotation.dart';

abstract class BaseObject {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: '_status')
  String baseStatus;

  DateTime createdAt;
}
