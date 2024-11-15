import 'dart:io';

import 'package:all_about_whats_new/app/service/whats_new_service.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp() async {
    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setMockInitialValues({});
    (await SharedPreferences.getInstance()).clear();

    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '1', buildSignature: 'test');
  }

  test('showing multiple whats new definitions', () async {
    await setUp();
    // Whatsnew definition has two entries
    final file = File('test/whats_new_definition.json');
    final json = await file.readAsString();
    await WhatsNewService.instance.initWhatsNewFromJson(json);

    var initialWhatsNewDefinitionsCount = WhatsNewService.instance.whatsNewDefinitionsCount;
    expect(initialWhatsNewDefinitionsCount, 2);

    var shouldShow = await WhatsNewService.instance.shouldShowWhatsNew();
    expect(shouldShow, isTrue);

    // should have a second one
    final canShowNext = await WhatsNewService.instance.moveToNextWhatsNewIfPossible();
    expect(canShowNext, isTrue);

    final whatsNewDefinitionsCountAfterFirstShow = WhatsNewService.instance.whatsNewDefinitionsCount;
    expect(whatsNewDefinitionsCountAfterFirstShow, 1);

    // should not have a third one
    final cannotShowNext = await WhatsNewService.instance.moveToNextWhatsNewIfPossible();
    expect(cannotShowNext, isFalse);

    // Should now show the next time

    WhatsNewService.instance.reInititWhatsNewFromJson(json);

    initialWhatsNewDefinitionsCount = WhatsNewService.instance.whatsNewDefinitionsCount;
    expect(initialWhatsNewDefinitionsCount, 2);

    shouldShow = await WhatsNewService.instance.shouldShowWhatsNew();
    expect(shouldShow, isFalse);
  });

  test('whats new definitions are filtered on shouldShowWhatsNew', () async {
    await setUp();
    // Whatsnew definition has two entries
    final file = File('test/whats_new_definition.json');
    final json = await file.readAsString();
    await WhatsNewService.instance.initWhatsNewFromJson(json);
    var shouldShow = await WhatsNewService.instance.shouldShowWhatsNew();
    expect(shouldShow, isTrue);

    var initialWhatsNewDefinitionsCount = WhatsNewService.instance.whatsNewDefinitionsCount;
    expect(initialWhatsNewDefinitionsCount, 2);

    var canShowNext = await WhatsNewService.instance.moveToNextWhatsNewIfPossible();
    expect(canShowNext, isTrue);

    WhatsNewService.instance.reInititWhatsNewFromJson(json);
    shouldShow = await WhatsNewService.instance.shouldShowWhatsNew();
    expect(shouldShow, isTrue);

    initialWhatsNewDefinitionsCount = WhatsNewService.instance.whatsNewDefinitionsCount;
    expect(initialWhatsNewDefinitionsCount, 1);

    canShowNext = await WhatsNewService.instance.moveToNextWhatsNewIfPossible();
    expect(canShowNext, false);

    WhatsNewService.instance.reInititWhatsNewFromJson(json);
    shouldShow = await WhatsNewService.instance.shouldShowWhatsNew();
    expect(shouldShow, isFalse);
  });

  test('should show whats new version code', () async {
    await setUp();

    final sharedPreferences = await SharedPreferences.getInstance();

    final file = File('test/whats_new_definition.json');
    final json = await file.readAsString();
    await WhatsNewService.instance.initWhatsNewFromJson(json);

    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '1', buildSignature: 'test');
    expect(await WhatsNewService.instance.shouldShowWhatsNew(), isTrue);

    await sharedPreferences.clear();

    WhatsNewService.instance.reInititWhatsNewFromJson(json);
    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '2', buildSignature: 'test');
    expect(await WhatsNewService.instance.shouldShowWhatsNew(), isTrue);

    await sharedPreferences.clear();

    WhatsNewService.instance.reInititWhatsNewFromJson(json);
    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '3', buildSignature: 'test');
    expect(await WhatsNewService.instance.shouldShowWhatsNew(), isFalse);
  });

  test('should show whats new in time range', () async {
    await setUp();

    final sharedPreferences = await SharedPreferences.getInstance();

    final file = File('test/whats_new_definition_with_range.json');
    final json = await file.readAsString();
    WhatsNewService.instance.initWhatsNewFromJson(json);

    var shouldShow = await withClock(
      Clock.fixed(DateTime(2024, 11, 13)),
      () async {
        await sharedPreferences.clear();
        return await WhatsNewService.instance.shouldShowWhatsNew();
      },
    );

    expect(shouldShow, isTrue);
    var initialWhatsNewDefinitionsCount = WhatsNewService.instance.whatsNewDefinitionsCount;
    expect(initialWhatsNewDefinitionsCount, 2);

    shouldShow = await withClock(
      Clock.fixed(DateTime(2023, 10, 11)),
      () async {
        await sharedPreferences.clear();
        return await WhatsNewService.instance.shouldShowWhatsNew();
      },
    );

    expect(shouldShow, isTrue);

    initialWhatsNewDefinitionsCount = WhatsNewService.instance.whatsNewDefinitionsCount;
    expect(initialWhatsNewDefinitionsCount, 1);
  });
}
