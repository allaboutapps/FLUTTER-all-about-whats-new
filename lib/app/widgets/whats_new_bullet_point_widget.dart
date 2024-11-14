import 'package:all_about_whats_new/app/models/whats_new_definition.dart';
import 'package:all_about_whats_new/app/service/whats_new_service.dart';
import 'package:flutter/material.dart';

class WhatsNewBulletPointModel {
  WhatsNewBulletPointModel({
    required this.titleTextStyle,
    required this.descriptionTextStyle,
    required this.iconBackgroundColor,
    required this.iconColor,
  });

  final TextStyle titleTextStyle;
  final TextStyle descriptionTextStyle;
  final Color iconBackgroundColor;
  final Color iconColor;
}

class WhatsNewBulletPoint extends StatelessWidget {
  const WhatsNewBulletPoint({
    super.key,
    required this.model,
    required this.entry,
  });

  final WhatsNewBulletPointModel model;
  final WhatsNewEntryBulletpoint entry;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: model.iconBackgroundColor,
          foregroundColor: model.iconColor,
          child: Icon(
            IconData(entry.materialIcon, fontFamily: 'MaterialIcons'),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(entry.title.tr(context), style: model.titleTextStyle),
              Text(entry.description.tr(context), style: model.descriptionTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}
