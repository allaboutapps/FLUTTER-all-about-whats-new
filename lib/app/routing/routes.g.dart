// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $whatsNewRoute,
    ];

RouteBase get $whatsNewRoute => GoRouteData.$route(
      path: '/whats-new',
      factory: $WhatsNewRouteExtension._fromState,
    );

extension $WhatsNewRouteExtension on WhatsNewRoute {
  static WhatsNewRoute _fromState(GoRouterState state) => WhatsNewRoute(
        $extra: state.extra as WhatsNewScreenModel,
      );

  String get location => GoRouteData.$location(
        '/whats-new',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
