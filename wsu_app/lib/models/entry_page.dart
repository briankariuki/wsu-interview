import 'package:json_annotation/json_annotation.dart';
import 'package:wsu_app/models/models.dart';

part 'entry_page.g.dart';

@JsonSerializable()
class EntryPage {
  List<Entry> docs;
  int page;
  int pages;

  static EntryPage fromJson(dynamic json) => _$EntryPageFromJson(json);

  Map<String, dynamic> toJson() => _$EntryPageToJson(this);
}
