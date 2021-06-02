// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryPage _$EntryPageFromJson(Map<String, dynamic> json) {
  return EntryPage()
    ..docs = (json['docs'] as List)
        ?.map(
            (e) => e == null ? null : Entry.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..page = json['page'] as int
    ..pages = json['pages'] as int;
}

Map<String, dynamic> _$EntryPageToJson(EntryPage instance) => <String, dynamic>{
      'docs': instance.docs,
      'page': instance.page,
      'pages': instance.pages,
    };
