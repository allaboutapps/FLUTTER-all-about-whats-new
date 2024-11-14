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
      title: Map<String, String>.from(json['title'] as Map),
      buttonTitle: Map<String, String>.from(json['buttonTitle'] as Map),
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
      title: Map<String, String>.from(json['title'] as Map),
      description: Map<String, String>.from(json['description'] as Map),
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
      markdown: Map<String, String>.from(json['markdown'] as Map),
    );

Map<String, dynamic> _$WhatsNewEntryMarkdownToJson(
        WhatsNewEntryMarkdown instance) =>
    <String, dynamic>{
      'markdown': instance.markdown,
    };

WhatsNewEntryLink _$WhatsNewEntryLinkFromJson(Map<String, dynamic> json) =>
    WhatsNewEntryLink(
      url: json['url'] as String,
      title: Map<String, String>.from(json['title'] as Map),
    );

Map<String, dynamic> _$WhatsNewEntryLinkToJson(WhatsNewEntryLink instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
    };
