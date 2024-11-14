// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whats_new_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WhatsNewDefinition _$WhatsNewDefinitionFromJson(Map<String, dynamic> json) =>
    WhatsNewDefinition(
      whatsNewId: (json['whatsNewId'] as num).toInt(),
      minVersionCode: (json['minVersionCode'] as num).toInt(),
      maxVersionCode: (json['maxVersionCode'] as num).toInt(),
      validFrom: json['validFrom'] == null
          ? null
          : DateTime.parse(json['validFrom'] as String),
      validTo: json['validTo'] == null
          ? null
          : DateTime.parse(json['validTo'] as String),
      content:
          WhatsNewContent.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WhatsNewDefinitionToJson(WhatsNewDefinition instance) =>
    <String, dynamic>{
      'whatsNewId': instance.whatsNewId,
      'minVersionCode': instance.minVersionCode,
      'maxVersionCode': instance.maxVersionCode,
      'validFrom': instance.validFrom?.toIso8601String(),
      'validTo': instance.validTo?.toIso8601String(),
      'content': instance.content,
    };

WhatsNewContent _$WhatsNewContentFromJson(Map<String, dynamic> json) =>
    WhatsNewContent(
      entries: (json['entries'] as List<dynamic>)
          .map((e) => WhatsNewEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      buttonTitle: json['buttonTitle'] as String,
    );

Map<String, dynamic> _$WhatsNewContentToJson(WhatsNewContent instance) =>
    <String, dynamic>{
      'entries': instance.entries,
      'title': instance.title,
      'buttonTitle': instance.buttonTitle,
    };

WhatsNewEntryBulletpoint _$WhatsNewEntryBulletpointFromJson(
        Map<String, dynamic> json) =>
    WhatsNewEntryBulletpoint(
      title: json['title'] as String,
      description: json['description'] as String,
      materialIcon: (json['materialIcon'] as num).toInt(),
    );

Map<String, dynamic> _$WhatsNewEntryBulletpointToJson(
        WhatsNewEntryBulletpoint instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'materialIcon': instance.materialIcon,
    };

WhatsNewEntryImage _$WhatsNewEntryImageFromJson(Map<String, dynamic> json) =>
    WhatsNewEntryImage(
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$WhatsNewEntryImageToJson(WhatsNewEntryImage instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
    };

WhatsNewEntryMarkdown _$WhatsNewEntryMarkdownFromJson(
        Map<String, dynamic> json) =>
    WhatsNewEntryMarkdown(
      markdown: json['markdown'] as String,
    );

Map<String, dynamic> _$WhatsNewEntryMarkdownToJson(
        WhatsNewEntryMarkdown instance) =>
    <String, dynamic>{
      'markdown': instance.markdown,
    };
