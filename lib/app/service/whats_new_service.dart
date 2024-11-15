import 'dart:async';
import 'dart:convert';

import 'package:all_about_whats_new/app/models/whats_new_definition.dart';
import 'package:all_about_whats_new/app/routing/routes.dart';
import 'package:all_about_whats_new/app/widgets/whats_new_bullet_point_widget.dart';
import 'package:all_about_whats_new/app/widgets/whats_new_image_widget.dart';
import 'package:all_about_whats_new/app/widgets/whats_new_link_widget.dart';
import 'package:all_about_whats_new/app/widgets/whats_new_markdown_widget.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

part '../views/whats_new_screen.dart';

const lastShownWhatsNew = 'lastShownWhatsNew';

class WhatsNewService {
  WhatsNewService._();

  static final WhatsNewService instance = WhatsNewService._();

  List<WhatsNewDefinition>? _whatsNewDefinitions;
  late final SharedPreferences sharedPreferences;

  Future<void> initWhatsNew({String? whatsNewDefinitionUrl}) async {
    if (whatsNewDefinitionUrl == null) {
      return;
    }

    sharedPreferences = await SharedPreferences.getInstance();

    try {
      final whatsNewDefinitionResponse = await http.get(Uri.parse(whatsNewDefinitionUrl)).timeout(const Duration(seconds: 2));

      final List<dynamic> jsonList = jsonDecode(whatsNewDefinitionResponse.body);
      _whatsNewDefinitions = jsonList.map((json) => WhatsNewDefinition.fromJson(json)).toList();
    } catch (_) {
      return;
    }
  }

  @visibleForTesting
  Future<void> initWhatsNewFromJson(String whatsNewDefinitionJson) async {
    sharedPreferences = await SharedPreferences.getInstance();
    final List<dynamic> jsonList = jsonDecode(whatsNewDefinitionJson);
    _whatsNewDefinitions = jsonList.map((json) => WhatsNewDefinition.fromJson(json)).toList();
  }

  @visibleForTesting
  void reInititWhatsNewFromJson(String whatsNewDefinitionJson) {
    final List<dynamic> jsonList = jsonDecode(whatsNewDefinitionJson);
    _whatsNewDefinitions = jsonList.map((json) => WhatsNewDefinition.fromJson(json)).toList();
  }

  @visibleForTesting
  int get whatsNewDefinitionsCount => _whatsNewDefinitions?.length ?? 0;

  // In the beginning there has to be one
  // On every continue click as well if moveToNextWhatsNewIfPossible returns true
  WhatsNewDefinition get currentWhatsNewDefinition => _whatsNewDefinitions!.first;

  // When clicking on next moveToNextWhatsNewIfPossible evaluates if there is a next whats new definition and stores the currently shown whats new id
  // It also removes the currently shown whats new definition from the list
  Future<bool> moveToNextWhatsNewIfPossible() async {
    // Set currently shown whats new id
    await sharedPreferences.setInt(lastShownWhatsNew, _whatsNewDefinitions!.first.whatsNewId);

    // Remove first whats new definition
    _whatsNewDefinitions?.removeAt(0);

    // Return true if there are more whats new definitions
    return _whatsNewDefinitions!.isNotEmpty;
  }

  Future<bool> shouldShowWhatsNew() async {
    if (_whatsNewDefinitions == null) {
      return false;
    }

    try {
      final lastShownWhatsNewId = sharedPreferences.getInt(lastShownWhatsNew);
      final localVersionCode = int.tryParse((await PackageInfo.fromPlatform()).buildNumber);

      if (localVersionCode == null) {
        return false;
      }

      // Remove all whats new definitions that are not valid at the current date (if date is set)
      _whatsNewDefinitions!.removeWhere((definition) =>
          definition.validFrom != null &&
          definition.validTo != null &&
          (definition.validFrom!.isAfter(clock.now()) || definition.validTo!.isBefore(clock.now())));

      // Remove all whats new definitions that are not valid for the current version code
      _whatsNewDefinitions!
          .removeWhere((definition) => definition.minVersionCode > localVersionCode || definition.maxVersionCode < localVersionCode);

      // Remove all whats new definitions that have already been shown
      _whatsNewDefinitions!.removeWhere((definition) => lastShownWhatsNewId != null && definition.whatsNewId <= lastShownWhatsNewId);

      // Sort whats new definitions by whats new id
      _whatsNewDefinitions!.sort((a, b) => a.whatsNewId.compareTo(b.whatsNewId));

      // Return false if the last shown whats new id is the same as the last whats new id
      if (lastShownWhatsNewId == _whatsNewDefinitions!.last.whatsNewId) return false;

      return _whatsNewDefinitions!.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
