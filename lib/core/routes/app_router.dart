import 'dart:io';

import 'package:flutter/material.dart';
import 'package:harmony/core/routes/custom_page_router.dart';
import 'package:harmony/core/routes/routes.dart';
import 'package:harmony/core/routes/transitions.dart';
import 'package:harmony/core/routes/transitions_enum.dart';

class AppRouter {
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration modalAnimationDuration = Duration(milliseconds: 400);
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case Routes.splash:
        page = const Placeholder();
        break;
      case Routes.login:
        page = const Placeholder();
        break;
      case Routes.register:
        page = const Placeholder();
        break;
      case Routes.home:
        page = const Placeholder();
        break;
      case Routes.profile:
        page = const Placeholder();
        break;
      case Routes.settings:
        page = const Placeholder();
        break;
      case Routes.about:
        page = const Placeholder();
        break;
      case Routes.contact:
        page = const Placeholder();
        break;
      case Routes.terms:
        page = const Placeholder();
        break;
      case Routes.privacy:
        page = const Placeholder();
        break;
      default:
        page = const Placeholder(); // Not found page
        break;
    }

    return AppRouter().buildAdaptivePageRoute(page: page, settings: settings);
  }

  Route<dynamic> buildAdaptivePageRoute({
    required Widget page,
    required RouteSettings settings,
    RouteTransition transitionType = RouteTransition.normal,
    bool isModal = false,
    Duration? duration,
  }) {
    final Map<String, dynamic>? args =
        settings.arguments as Map<String, dynamic>?;
    final bool fullscreenDialog = args?['fullscreenDialog'] as bool? ?? isModal;
    final Duration transitionDuration =
        duration ??
        (isModal ? modalAnimationDuration : defaultAnimationDuration);
    final RouteTransition transition =
        args?['transition'] as RouteTransition? ?? transitionType;
    final RouteTransitionsBuilder? customTransition =
        args?['customTransition'] as RouteTransitionsBuilder?;

    if (Platform.isIOS) {
      return CustomCupertinoPageRoute(
        builder: (_) => page,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        customTransitionDuration: transitionDuration,
        customTransition:
            (customTransition != null)
                ? customTransition
                : TransitionBuilders.getTransitionBuilder(
                  null,
                  transition,
                  TargetPlatform.iOS,
                ),
        isRtl:
            false, // This should be determined from context in a real implementation
      );
    } else {
      return CustomMaterialPageRoute(
        builder: (_) => page,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        transitionDuration: transitionDuration,
        customTransition:
            (customTransition != null)
                ? customTransition
                : TransitionBuilders.getTransitionBuilder(
                  null,
                  transition,
                  TargetPlatform.android,
                ),
        isRtl:
            false, // This should be determined from context in a real implementation
      );
    }
  }
}
