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
  }

  test('should show whats new only once', () async {
    await setUp();
    final file = File('test/whats_new_definition.json');
    final json = await file.readAsString();
    WhatsNewService.instance.initWhatsNewFromJson(json);

    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '1', buildSignature: 'test');
    expect(await WhatsNewService.instance.shouldShowWhatsNew(), isTrue);
    expect(await WhatsNewService.instance.shouldShowWhatsNew(), isFalse);
  });

  test('should show whats new version code', () async {
    await setUp();

    final sharedPreferences = await SharedPreferences.getInstance();

    final file = File('test/whats_new_definition.json');
    final json = await file.readAsString();
    WhatsNewService.instance.initWhatsNewFromJson(json);

    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '1', buildSignature: 'test');
    expect(await WhatsNewService.instance.shouldShowWhatsNew(), isTrue);

    await sharedPreferences.clear();

    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '2', buildSignature: 'test');
    expect(await WhatsNewService.instance.shouldShowWhatsNew(), isTrue);

    await sharedPreferences.clear();

    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '3', buildSignature: 'test');
    expect(await WhatsNewService.instance.shouldShowWhatsNew(), isFalse);
  });

  test('should show whats new in time range', () async {
    await setUp();

    final sharedPreferences = await SharedPreferences.getInstance();

    final file = File('test/whats_new_definition_with_range.json');
    final json = await file.readAsString();
    WhatsNewService.instance.initWhatsNewFromJson(json);

    PackageInfo.setMockInitialValues(appName: 'test', packageName: 'test', version: '1.0', buildNumber: '1', buildSignature: 'test');

    var shouldShow = await withClock(
      Clock.fixed(DateTime(2024, 11, 13)),
      () async {
        await sharedPreferences.clear();
        return await WhatsNewService.instance.shouldShowWhatsNew();
      },
    );

    expect(shouldShow, isTrue);

    shouldShow = await withClock(
      Clock.fixed(DateTime(2023, 10, 11)),
      () async {
        await sharedPreferences.clear();
        return await WhatsNewService.instance.shouldShowWhatsNew();
      },
    );

    expect(shouldShow, isFalse);
  });
}
