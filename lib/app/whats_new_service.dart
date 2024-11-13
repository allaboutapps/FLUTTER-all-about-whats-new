import 'dart:convert';

import 'package:all_about_whats_new/app/whats_new_definition.dart';
import 'package:clock/clock.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'whats_new_screen.dart';

const lastShownWhatsNew = 'lastShownWhatsNew';

class WhatsNewService {
  WhatsNewService._();

  static final WhatsNewService instance = WhatsNewService._();

  WhatsNewDefinition? _whatsNewDefinition;

  Future<void> initWhatsNew({String? whatsNewDefinitionUrl}) async {
    if (whatsNewDefinitionUrl == null) {
      return;
    }

    try {
      final whatsNewDefinitionResponse = await http.get(Uri.parse(whatsNewDefinitionUrl)).timeout(const Duration(seconds: 2));
      final whatsNewDefinition = WhatsNewDefinition.fromJson(jsonDecode(whatsNewDefinitionResponse.body));
      _whatsNewDefinition = whatsNewDefinition;
    } catch (_) {
      return;
    }
  }

  @visibleForTesting
  Future<void> initWhatsNewFromJson(String whatsNewDefinitionJson) async {
    _whatsNewDefinition = WhatsNewDefinition.fromJson(jsonDecode(whatsNewDefinitionJson));
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
        final currentDateTime = clock.now();
        if (_whatsNewDefinition!.validFrom!.isAfter(currentDateTime) || _whatsNewDefinition!.validTo!.isBefore(currentDateTime)) {
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
}
