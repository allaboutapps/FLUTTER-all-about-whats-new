import 'dart:convert';

import 'package:all_about_whats_new/app/whats_new_definition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'whats_new_screen.dart';

final whatsNewDefinitionJson = '''
{
  "whatsNewId": 1,
  "minVersionCode": 1,
  "maxVersionCode": 2,
  "content":{
    "title": "blog_title",
    "buttonTitle": "general_action_continue",
    "entries": [
      {
        "title": "blog_feedback_question",
        "description": "buy_sensor_apple_watch_info",
        "materialIcon": 59658
      },
      {
        "title": "blog_feedback_question",
        "description": "buy_sensor_apple_watch_info",
        "materialIcon": 59675
      },
      {
        "title": "blog_feedback_question",
        "description": "buy_sensor_apple_watch_info",
        "materialIcon": 59675
      },
      {
        "title": "blog_feedback_question",
        "description": "buy_sensor_apple_watch_info",
        "materialIcon": 59675
      },
      {
        "title": "blog_feedback_question",
        "description": "buy_sensor_apple_watch_info",
        "materialIcon": 59675
      },
      {
        "title": "blog_feedback_question",
        "description": "buy_sensor_apple_watch_info",
        "materialIcon": 59675
      },
      {
        "title": "blog_feedback_question",
        "description": "buy_sensor_apple_watch_info",
        "materialIcon": 59675
      }
    ]
  }
}

''';

const lastShownWhatsNew = 'lastShownWhatsNew';

class WhatsNewService {
  WhatsNewService._();

  static final WhatsNewService instance = WhatsNewService._();

  Future<void> initWhatsNew({String? whatsNewDefinitionUrl}) async {
    // if (whatsNewDefinitionUrl == null) {
    //   return;
    // }

    try {
      // final whatsNewDefinitionResponse = await http.get(Uri.parse(whatsNewDefinitionUrl)).timeout(const Duration(seconds: 2));
      // final whatsNewDefinition = WhatsNewDefinition.fromJson(jsonDecode(whatsNewDefinitionResponse.body));
      final whatsNewDefinition = WhatsNewDefinition.fromJson(jsonDecode(whatsNewDefinitionJson));
      _whatsNewDefinition = whatsNewDefinition;
    } catch (_) {
      return;
    }
  }

  Future<bool> shouldShowWhatsNew() async {
    if (_whatsNewDefinition == null) {
      return false;
    }

    try {
      final sharedPreferences = await SharedPreferences.getInstance();

      final lastShownWhatsNewId = sharedPreferences.getInt(lastShownWhatsNew);
      final localVersionCode = int.tryParse((await PackageInfo.fromPlatform()).buildNumber);

      if (localVersionCode == null || lastShownWhatsNewId == _whatsNewDefinition!.whatsNewId) return false;

      if (_whatsNewDefinition!.validFrom != null && _whatsNewDefinition!.validTo != null) {
        if (_whatsNewDefinition!.validFrom!.isAfter(DateTime.now()) || _whatsNewDefinition!.validTo!.isBefore(DateTime.now())) {
          return false;
        }
      }

      if (_whatsNewDefinition!.minVersionCode <= localVersionCode && _whatsNewDefinition!.maxVersionCode >= localVersionCode) {
        await sharedPreferences.setInt(lastShownWhatsNew, localVersionCode);

        return true;
      }
    } catch (_) {
      return false;
    }

    return false;
  }

  WhatsNewDefinition? _whatsNewDefinition;
}
