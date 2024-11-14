import 'package:all_about_whats_new/app/models/whats_new_definition.dart';
import 'package:flutter/material.dart';

class WhatsNewImage extends StatelessWidget {
  const WhatsNewImage({super.key, required this.entry});

  final WhatsNewEntryImage entry;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      entry.imageUrl,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stack) => const SizedBox.shrink(),
      loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : const SizedBox.shrink(),
    );
  }
}
