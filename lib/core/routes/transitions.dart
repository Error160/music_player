import 'package:flutter/material.dart';
import 'package:harmony/core/routes/transitions_enum.dart';

class TransitionBuilders {
  /// Get a transition builder based on the selected transition type and platform
  static RouteTransitionsBuilder getTransitionBuilder(
    PageRoute<dynamic>? route,
    RouteTransition transition,
    TargetPlatform platform, {
    bool isRtl = false,
  }) {
    switch (transition) {
      case RouteTransition.normal:
        return (context, animation, secondaryAnimation, child) =>
            _buildDefaultTransition(route, platform, isRtl: isRtl)(
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case RouteTransition.fade:
        return (context, animation, secondaryAnimation, child) =>
            _buildFadeTransition(
              route!,
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case RouteTransition.slideRight:
        return (context, animation, secondaryAnimation, child) =>
            isRtl
                ? _buildSlideLeftTransition(
                  route!,
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                )
                : _buildSlideRightTransition(
                  route!,
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );

      case RouteTransition.slideLeft:
        return (context, animation, secondaryAnimation, child) =>
            isRtl
                ? _buildSlideRightTransition(
                  route!,
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                )
                : _buildSlideLeftTransition(
                  route!,
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );

      case RouteTransition.slideUp:
        return (context, animation, secondaryAnimation, child) =>
            _buildSlideUpTransition(
              route!,
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case RouteTransition.slideDown:
        return (context, animation, secondaryAnimation, child) =>
            _buildSlideDownTransition(
              route!,
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case RouteTransition.scale:
        return (context, animation, secondaryAnimation, child) =>
            _buildScaleTransition(
              route!,
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case RouteTransition.rotation:
        return (context, animation, secondaryAnimation, child) =>
            _buildRotationTransition(
              route!,
              context,
              animation,
              secondaryAnimation,
              child,
            );

      case RouteTransition.slideAndFade:
        return (context, animation, secondaryAnimation, child) =>
            isRtl
                ? _buildRtlSlideAndFadeTransition(
                  route!,
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                )
                : _buildSlideAndFadeTransition(
                  route!,
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );

      case RouteTransition.zoom:
        return (context, animation, secondaryAnimation, child) =>
            _buildZoomTransition(
              route!,
              context,
              animation,
              secondaryAnimation,
              child,
            );
    }
  }

  /// Default platform-specific transition with RTL support
  static RouteTransitionsBuilder _buildDefaultTransition(
    PageRoute<dynamic>? route,
    TargetPlatform platform, {
    bool isRtl = false,
  }) {
    return (context, animation, secondaryAnimation, child) {
      switch (platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return isRtl
              ? _buildSlideLeftTransition(
                route!,
                context,
                animation,
                secondaryAnimation,
                child,
              )
              : _buildSlideRightTransition(
                route!,
                context,
                animation,
                secondaryAnimation,
                child,
              );
        default:
          return _buildFadeTransition(
            route!,
            context,
            animation,
            secondaryAnimation,
            child,
          );
      }
    };
  }

  /// Simple fade transition
  static Widget _buildFadeTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  /// Slide from right to left (iOS style)
  static Widget _buildSlideRightTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  /// Slide from left to right
  static Widget _buildSlideLeftTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  /// Slide from bottom to top
  static Widget _buildSlideUpTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  /// Slide from top to bottom
  static Widget _buildSlideDownTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }

  /// Scale transition
  static Widget _buildScaleTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }

  /// Rotation and scale transition
  static Widget _buildRotationTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return RotationTransition(
      turns: Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      ),
      child: ScaleTransition(scale: animation, child: child),
    );
  }

  /// Combined slide and fade transition (left-to-right)
  static Widget _buildSlideAndFadeTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  /// Combined slide and fade transition for RTL (right-to-left)
  static Widget _buildRtlSlideAndFadeTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  /// Zoom transition that expands from center
  static Widget _buildZoomTransition(
    PageRoute<dynamic> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Create curved animations
    final Animation<double> zoomAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticIn,
    );

    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(zoomAnimation),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}
