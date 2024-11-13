import 'package:all_about_whats_new/app/whats_new_definition.dart';
import 'package:all_about_whats_new/app/whats_new_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sheet/route.dart';

part 'routes.g.dart';

@TypedGoRoute<WhatsNewRoute>(path: '/whats-new')
class WhatsNewRoute extends GoRouteData {
  WhatsNewRoute({required this.$extra});

  final WhatsNewScreenModel $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CupertinoSheetPage(
        child: WhatsNewScreen(model: $extra),
      );
}
