import 'package:flutter/material.dart';
import 'package:harmony/core/routes/adaptive_router.dart';
import 'package:harmony/core/routes/transitions_enum.dart';

/// Extensions on BuildContext to make navigation more concise
extension NavigationExtensions on BuildContext {
  /// Navigate to a new screen
  Future<T?> push<T extends Object?>({
    required Widget page,
    String? routeName,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
    RouteTransition transition = RouteTransition.normal,
    RouteTransitionsBuilder? customTransition,
  }) {
    return AdaptiveRouter.push<T>(
      context: this,
      page: page,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: transitionDuration,
      transition: transition,
      customTransition: customTransition,
    );
  }

  /// Replace current screen with a new one
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>({
    required Widget page,
    String? routeName,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
    RouteTransition transition = RouteTransition.normal,
    RouteTransitionsBuilder? customTransition,
    TO? result,
  }) {
    return AdaptiveRouter.pushReplacement<T, TO>(
      context: this,
      page: page,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: transitionDuration,
      transition: transition,
      customTransition: customTransition,
      result: result,
    );
  }

  /// Push and remove all previous routes
  Future<T?> pushAndRemoveUntil<T extends Object?>({
    required Widget page,
    required RoutePredicate predicate,
    String? routeName,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
    RouteTransition transition = RouteTransition.normal,
    RouteTransitionsBuilder? customTransition,
  }) {
    return AdaptiveRouter.pushAndRemoveUntil<T>(
      context: this,
      page: page,
      predicate: predicate,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: transitionDuration,
      transition: transition,
      customTransition: customTransition,
    );
  }

  /// Push named route with custom transition
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool fullscreenDialog = false,
    Duration? transitionDuration,
    RouteTransition transition = RouteTransition.normal,
    RouteTransitionsBuilder? customTransition,
  }) {
    // Use the route generator from the app's router configuration
    // which should handle the transition parameters
    return Navigator.of(this).pushNamed<T>(
      routeName,
      arguments: {
        'arguments': arguments,
        'fullscreenDialog': fullscreenDialog,
        'transitionDuration': transitionDuration,
        'transition': transition,
        'customTransition': customTransition,
      },
    );
  }

  /// Pop the current route
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// Check if navigation can pop
  bool get canPop => Navigator.of(this).canPop();

  /// Pop until matching predicate
  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// Pop all routes except first
  void popUntilRoot() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  /// Pop specified number of routes
  void popToCount(int count) {
    int counter = 0;
    Navigator.of(this).popUntil((route) => ++counter > count);
  }

  /// Get the text direction (for RTL support)
  TextDirection get textDirection => Directionality.of(this);

  /// Check if directionality is RTL
  bool get isRTL => textDirection == TextDirection.rtl;
}
