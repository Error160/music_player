import 'package:flutter/material.dart';
import 'package:harmony/core/routes/custom_page_router.dart';
import 'package:harmony/core/routes/transitions.dart';
import 'package:harmony/core/routes/transitions_enum.dart';

/// A router that adapts to the current platform
class AdaptiveRouter {
  /// Push a new route onto the navigator
  static Future<T?> push<T extends Object?>({
    required BuildContext context,
    required Widget page,
    String? routeName,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
    RouteTransition transition = RouteTransition.normal,
    RouteTransitionsBuilder? customTransition,
  }) {
    final route = _buildPageRoute<T>(
      context: context,
      page: page,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: transitionDuration,
      transition: transition,
      customTransition: customTransition,
    );
    return Navigator.of(context).push(route);
  }

  /// Replace the current route with a new one
  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>({
    required BuildContext context,
    required Widget page,
    String? routeName,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
    RouteTransition transition = RouteTransition.normal,
    RouteTransitionsBuilder? customTransition,
    TO? result,
  }) {
    final route = _buildPageRoute<T>(
      context: context,
      page: page,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: transitionDuration,
      transition: transition,
      customTransition: customTransition,
    );
    return Navigator.of(context).pushReplacement(route, result: result);
  }

  /// Push a new route and remove routes until predicate is satisfied
  static Future<T?> pushAndRemoveUntil<T extends Object?>({
    required BuildContext context,
    required Widget page,
    required RoutePredicate predicate,
    String? routeName,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
    RouteTransition transition = RouteTransition.normal,
    RouteTransitionsBuilder? customTransition,
  }) {
    final route = _buildPageRoute<T>(
      context: context,
      page: page,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: transitionDuration,
      transition: transition,
      customTransition: customTransition,
    );
    return Navigator.of(context).pushAndRemoveUntil(route, predicate);
  }

  /// Build a platform-adaptive page route
  static PageRoute<T> _buildPageRoute<T>({
    required BuildContext context,
    required Widget page,
    String? routeName,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
    RouteTransition transition = RouteTransition.normal,
    RouteTransitionsBuilder? customTransition,
  }) {
    final platform = Theme.of(context).platform;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // Use custom transition if provided, otherwise use the transition type
    final transitionBuilder =
        customTransition ??
        TransitionBuilders.getTransitionBuilder(
          null, // This will be set after route creation
          transition,
          platform,
          isRtl: isRtl,
        );

    // Use platform-specific route
    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return CustomCupertinoPageRoute<T>(
        builder: (_) => page,
        settings: RouteSettings(name: routeName),
        fullscreenDialog: fullscreenDialog,
        customTransitionDuration:
            transitionDuration ?? const Duration(milliseconds: 400),
        customTransition: transitionBuilder,
        isRtl: isRtl,
      );
    } else {
      return CustomMaterialPageRoute<T>(
        builder: (_) => page,
        settings: RouteSettings(name: routeName),
        fullscreenDialog: fullscreenDialog,
        transitionDuration:
            transitionDuration ?? const Duration(milliseconds: 300),
        customTransition: transitionBuilder,
        isRtl: isRtl,
      );
    }
  }
}
