import 'package:json_annotation/json_annotation.dart';

part 'user_create.g.dart';

@JsonSerializable()
class UserCreate {
  String displayName;

  UserCreate({
    this.displayName,
  });

  static UserCreate fromJson(dynamic json) => _$UserCreateFromJson(json);

  @override
  String toString() => toJson().toString();

  Map<String, dynamic> toJson() => _$UserCreateToJson(this);
}
