import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that provides hover **and keyboard-focus** effects for cards.
///
/// When [onActivate] is provided the card becomes keyboard-activatable
/// (Enter / Space) and gains a visible focus ring when reached via Tab.
/// A [semanticLabel] is used to describe the card to screen readers.
class HoverCard extends StatefulWidget {
  /// The child widget to wrap with hover effects
  final Widget child;

  /// Scale factor when hovered or focused (default 1.05)
  final double hoverScale;

  /// Duration of the hover animation
  final Duration duration;

  /// Whether to add shadow on hover / focus
  final bool showShadow;

  /// Border radius for the card
  final BorderRadius? borderRadius;

  /// Called when the user activates the card via tap, Enter, or Space.
  /// When null the card is not focusable via keyboard.
  final VoidCallback? onActivate;

  /// Accessible label read by screen readers.
  final String? semanticLabel;

  const HoverCard({
    super.key,
    required this.child,
    this.hoverScale = 1.05,
    this.duration = const Duration(milliseconds: 200),
    this.showShadow = true,
    this.borderRadius,
    this.onActivate,
    this.semanticLabel,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;
  bool _isFocused = false;

  bool get _highlighted => _isHovered || _isFocused;

  void _handleKeyEvent(KeyEvent event) {
    if (widget.onActivate == null) return;
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.space)) {
      widget.onActivate!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(16);

    Widget card = AnimatedScale(
      scale: _highlighted ? widget.hoverScale : 1.0,
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: widget.showShadow && _highlighted
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
          border: _isFocused
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : null,
        ),
        child: widget.child,
      ),
    );

    // Wrap in MouseRegion for hover detection
    card = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: card,
    );

    // If activatable, add keyboard Focus + GestureDetector + Semantics
    if (widget.onActivate != null) {
      card = Semantics(
        button: true,
        label: widget.semanticLabel,
        child: Focus(
          onKeyEvent: (_, event) {
            _handleKeyEvent(event);
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.space)) {
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: GestureDetector(
            onTap: widget.onActivate,
            child: card,
          ),
        ),
      );
    }

    return card;
  }
}
