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
  final Map<String, String> title;
  final Map<String, String> buttonTitle;

  factory WhatsNewContent.fromJson(Map<String, dynamic> json) => _$WhatsNewContentFromJson(json);
  Map<String, dynamic> toJson() => _$WhatsNewContentToJson(this);
}

enum WhatsNewEntryType { bulletpoint, image, markdown, link }

abstract class WhatsNewEntry {
  WhatsNewEntry({required this.type});

  final WhatsNewEntryType type;

  factory WhatsNewEntry.fromJson(Map<String, dynamic> json) {
    final type = WhatsNewEntryType.values.byName(json['type']);
    switch (type) {
      case WhatsNewEntryType.bulletpoint:
        return WhatsNewEntryBulletpoint.fromJson(json);
      case WhatsNewEntryType.image:
        return WhatsNewEntryImage.fromJson(json);
      case WhatsNewEntryType.markdown:
        return WhatsNewEntryMarkdown.fromJson(json);
      case WhatsNewEntryType.link:
        return WhatsNewEntryLink.fromJson(json);
    }
  }
  Map<String, dynamic> toJson() {
    switch (type) {
      case WhatsNewEntryType.bulletpoint:
        return (this as WhatsNewEntryBulletpoint).toJson();
      case WhatsNewEntryType.image:
        return (this as WhatsNewEntryImage).toJson();
      case WhatsNewEntryType.markdown:
        return (this as WhatsNewEntryMarkdown).toJson();
      case WhatsNewEntryType.link:
        return (this as WhatsNewEntryLink).toJson();
    }
  }
}

@JsonSerializable()
class WhatsNewEntryBulletpoint extends WhatsNewEntry {
  WhatsNewEntryBulletpoint({
    required this.title,
    required this.description,
    required this.materialIcon,
  }) : super(type: WhatsNewEntryType.bulletpoint);

  final Map<String, String> title;
  final Map<String, String> description;
  final int materialIcon;

  factory WhatsNewEntryBulletpoint.fromJson(Map<String, dynamic> json) => _$WhatsNewEntryBulletpointFromJson(json);
  Map<String, dynamic> toJson() => _$WhatsNewEntryBulletpointToJson(this);
}

@JsonSerializable()
class WhatsNewEntryImage extends WhatsNewEntry {
  WhatsNewEntryImage({required this.imageUrl}) : super(type: WhatsNewEntryType.image);

  final String imageUrl;

  factory WhatsNewEntryImage.fromJson(Map<String, dynamic> json) => _$WhatsNewEntryImageFromJson(json);
  Map<String, dynamic> toJson() => _$WhatsNewEntryImageToJson(this);
}

@JsonSerializable()
class WhatsNewEntryMarkdown extends WhatsNewEntry {
  WhatsNewEntryMarkdown({required this.markdown}) : super(type: WhatsNewEntryType.markdown);

  final Map<String, String> markdown;

  factory WhatsNewEntryMarkdown.fromJson(Map<String, dynamic> json) => _$WhatsNewEntryMarkdownFromJson(json);
  Map<String, dynamic> toJson() => _$WhatsNewEntryMarkdownToJson(this);
}

@JsonSerializable()
class WhatsNewEntryLink extends WhatsNewEntry {
  WhatsNewEntryLink({required this.url, required this.title}) : super(type: WhatsNewEntryType.link);

  final String url;
  final Map<String, String> title;

  factory WhatsNewEntryLink.fromJson(Map<String, dynamic> json) => _$WhatsNewEntryLinkFromJson(json);
  Map<String, dynamic> toJson() => _$WhatsNewEntryLinkToJson(this);
}
