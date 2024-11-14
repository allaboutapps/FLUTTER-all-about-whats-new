import 'package:all_about_whats_new/app/models/whats_new_definition.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WhatsNewLink extends StatelessWidget {
  const WhatsNewLink({super.key, required this.entry});

  final WhatsNewEntryLink entry;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          await launchUrlString(entry.url, mode: LaunchMode.externalApplication);
        },
        child: Text(entry.title));
  }
}
