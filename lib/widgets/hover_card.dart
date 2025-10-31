import 'package:flutter/material.dart';

/// A widget that provides hover effects for cards with scale and shadow animations
class HoverCard extends StatefulWidget {
  /// The child widget to wrap with hover effects
  final Widget child;
  
  /// Scale factor when hovered (default 1.05)
  final double hoverScale;
  
  /// Duration of the hover animation
  final Duration duration;
  
  /// Whether to add shadow on hover
  final bool showShadow;
  
  /// Border radius for the card
  final BorderRadius? borderRadius;

  const HoverCard({
    super.key,
    required this.child,
    this.hoverScale = 1.05,
    this.duration = const Duration(milliseconds: 200),
    this.showShadow = true,
    this.borderRadius,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? widget.hoverScale : 1.0,
        duration: widget.duration,
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: widget.duration,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            boxShadow: widget.showShadow && _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
