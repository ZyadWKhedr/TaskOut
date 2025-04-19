import 'package:flutter/material.dart';
import 'package:task_out/core/utils/app_sizes.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Duration duration;
  final double minScale;
  final Curve curve;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? width;
  final bool enabled;

  const AnimatedButton({
    super.key,
    required this.onTap,
    required this.child,
    this.duration = const Duration(milliseconds: 150),
    this.minScale = 0.95,
    this.curve = Curves.easeOut,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.enabled = true,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.minScale).animate(
      CurvedAnimation(parent: _animationController, curve: widget.curve),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context); // make sure sizes are initialized

    return MouseRegion(
      cursor:
          widget.enabled && widget.onTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown:
            widget.enabled && widget.onTap != null
                ? (_) => _animationController.forward()
                : null,
        onTapUp:
            widget.enabled && widget.onTap != null ? (_) => _onTapUp() : null,
        onTapCancel:
            widget.enabled && widget.onTap != null
                ? () => _animationController.reverse()
                : null,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.width, 
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Colors.blue,
                  borderRadius:
                      widget.borderRadius ??
                      BorderRadius.circular(AppSizes.blockWidth * 2),
                ),
                padding: widget.padding ?? EdgeInsets.all(AppSizes.paddingSm),
                child: Opacity(
                  opacity: widget.enabled ? 1.0 : 0.6,
                  child: child,
                ),
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }

  void _onTapUp() {
    _animationController.reverse().then((_) {
      if (widget.enabled && widget.onTap != null) {
        widget.onTap!();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
