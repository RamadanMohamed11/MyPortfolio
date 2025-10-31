import 'package:flutter/material.dart';

/// A custom elevated button with smooth hover effects
class HoverButton extends StatefulWidget {
  /// The text to display on the button
  final String text;
  
  /// Callback when button is pressed
  final VoidCallback? onPressed;
  
  /// Icon to display (optional)
  final IconData? icon;
  
  /// Base color of the button
  final Color? color;
  
  /// Hover color (default is slightly lighter)
  final Color? hoverColor;
  
  /// Text style
  final TextStyle? textStyle;
  
  /// Button padding
  final EdgeInsetsGeometry? padding;
  
  /// Border radius
  final BorderRadius? borderRadius;
  
  /// Minimum size
  final Size? minimumSize;

  const HoverButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.color,
    this.hoverColor,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.minimumSize,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color ?? Theme.of(context).primaryColor;
    final hoverColor = widget.hoverColor ?? 
        Color.lerp(baseColor, Colors.white, 0.1) ?? baseColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _isPressed 
                ? Color.lerp(baseColor, Colors.black, 0.1)
                : _isHovered 
                    ? hoverColor 
                    : baseColor,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: baseColor.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: baseColor.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              child: Container(
                constraints: widget.minimumSize != null
                    ? BoxConstraints(
                        minWidth: widget.minimumSize!.width,
                        minHeight: widget.minimumSize!.height,
                      )
                    : null,
                padding: widget.padding ?? 
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: Colors.white),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: widget.textStyle ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
