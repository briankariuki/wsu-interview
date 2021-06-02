import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class Error {
  String message;

  Error({this.message});

  static Error fromJson(dynamic json) => _$ErrorFromJson(json);

  @override
  String toString() => toJson().toString();

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
