/// Defines the type of transition animation to use when navigating between routes
enum RouteTransition {
  /// Default platform transition (slide for iOS, fade for Material)
  normal,

  /// Fade in/out transition - smooth opacity change
  fade,

  /// Slide from right to left (standard iOS navigation)
  slideRight,

  /// Slide from left to right (iOS back navigation)
  slideLeft,

  /// Slide from bottom to top (modal presentation)
  slideUp,

  /// Slide from top to bottom (dismissal animation)
  slideDown,

  /// Scale up from center (material design emphasis)
  scale,

  /// Rotate and scale (attention-grabbing transition)
  rotation,

  /// Both slide and fade (combined smooth transition)
  slideAndFade,

  /// Hero-like expansion from a point (material design pattern)
  zoom,
}
