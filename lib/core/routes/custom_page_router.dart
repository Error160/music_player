import 'package:flutter/material.dart';

/// Custom Cupertino page route with transition customization support
class CustomCupertinoPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final bool fullscreenDialog;
  final Duration customTransitionDuration;
  final RouteTransitionsBuilder customTransition;
  final bool isRtl;

  CustomCupertinoPageRoute({
    required this.builder,
    this.fullscreenDialog = false,
    this.customTransitionDuration = const Duration(milliseconds: 400),
    required this.customTransition,
    super.settings,
    this.isRtl = false,
  }) : super(fullscreenDialog: fullscreenDialog);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => customTransitionDuration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return customTransition(context, animation, secondaryAnimation, child);
  }

  // Support for iOS back swipe gesture
  @override
  bool get popGestureEnabled => !fullscreenDialog;

  // Edge for iOS back swipe gesture based on RTL status
  EdgeInsets get gestureInsetEdge =>
      isRtl ? EdgeInsets.only(left: 20.0) : EdgeInsets.only(right: 20.0);
}

/// Custom Material page route with transition customization support
class CustomMaterialPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final bool fullscreenDialog;
  final Duration transitionDuration;
  final RouteTransitionsBuilder customTransition;
  final bool isRtl;

  CustomMaterialPageRoute({
    required this.builder,
    this.fullscreenDialog = false,
    this.transitionDuration = const Duration(milliseconds: 300),
    required this.customTransition,
    RouteSettings? settings,
    this.isRtl = false,
  }) : super(fullscreenDialog: fullscreenDialog, settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return customTransition(context, animation, secondaryAnimation, child);
  }
}
