import 'package:json_annotation/json_annotation.dart';

part 'whats_new_definition.g.dart';

@JsonSerializable()
class WhatsNewDefinition {
  WhatsNewDefinition({
    required this.whatsNewId,
    required this.minVersionCode,
    required this.maxVersionCode,
    required this.validFrom,
    required this.validTo,
    required this.content,
  });

  final int whatsNewId;
  final int minVersionCode;
  final int maxVersionCode;
  final DateTime? validFrom;
  final DateTime? validTo;
  final WhatsNewContent content;

  factory WhatsNewDefinition.fromJson(Map<String, dynamic> json) => _$WhatsNewDefinitionFromJson(json);
  Map<String, dynamic> toJson() => _$WhatsNewDefinitionToJson(this);
}

@JsonSerializable()
class WhatsNewContent {
  WhatsNewContent({required this.entries, required this.title, required this.buttonTitle});

  final List<WhatsNewEntry> entries;
  final String title;
  final String buttonTitle;

  factory WhatsNewContent.fromJson(Map<String, dynamic> json) => _$WhatsNewContentFromJson(json);
  Map<String, dynamic> toJson() => _$WhatsNewContentToJson(this);
}

@JsonSerializable()
class WhatsNewEntry {
  WhatsNewEntry({
    required this.title,
    required this.description,
    required this.materialIcon,
  });

  final String title;
  final String description;
  final int materialIcon;

  factory WhatsNewEntry.fromJson(Map<String, dynamic> json) => _$WhatsNewEntryFromJson(json);
  Map<String, dynamic> toJson() => _$WhatsNewEntryToJson(this);
}
