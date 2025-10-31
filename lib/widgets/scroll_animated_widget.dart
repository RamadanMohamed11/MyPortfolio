import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A widget that animates its child with fade-in and slide-up effects
/// when it becomes visible in the viewport during scrolling
class ScrollAnimatedWidget extends StatefulWidget {
  /// The child widget to animate
  final Widget child;
  
  /// A unique key for visibility detection
  final String visibilityKey;
  
  /// Duration of the animation
  final Duration duration;
  
  /// Delay before animation starts
  final Duration delay;
  
  /// The vertical offset for the slide animation (in pixels)
  final double slideOffset;
  
  /// The visibility threshold (0.0 to 1.0) that triggers the animation
  final double visibilityThreshold;

  const ScrollAnimatedWidget({
    super.key,
    required this.child,
    required this.visibilityKey,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideOffset = 50.0,
    this.visibilityThreshold = 0.3,
  });

  @override
  State<ScrollAnimatedWidget> createState() => _ScrollAnimatedWidgetState();
}

class _ScrollAnimatedWidgetState extends State<ScrollAnimatedWidget> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.visibilityKey),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction >= widget.visibilityThreshold && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: widget.duration,
        child: _isVisible
            ? widget.child
                .animate(delay: widget.delay)
                .fadeIn(
                  duration: widget.duration,
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: widget.slideOffset / 100,
                  end: 0,
                  duration: widget.duration,
                  curve: Curves.easeOut,
                )
            : Transform.translate(
                offset: Offset(0, widget.slideOffset),
                child: Opacity(
                  opacity: 0.0,
                  child: widget.child,
                ),
              ),
      ),
    );
  }
}
