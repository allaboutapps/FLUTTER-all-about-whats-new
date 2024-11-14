import 'package:all_about_whats_new/app/models/whats_new_definition.dart';
import 'package:all_about_whats_new/app/service/whats_new_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class WhatsNewMarkdown extends StatelessWidget {
  const WhatsNewMarkdown({super.key, required this.entry});

  final WhatsNewEntryMarkdown entry;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(data: entry.markdown.tr(context));
  }
}
