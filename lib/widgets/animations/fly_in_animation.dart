import 'dart:math';

import 'package:flutter/material.dart';

class FlyInAnimation extends StatefulWidget {
  const FlyInAnimation({
    super.key,
    required this.child,
    required this.animate,
    this.removeScale,
    this.animationCompleted,
  });

  final Widget child;
  final bool animate;
  final bool? removeScale;
  final Function? animationCompleted;

  @override
  State<FlyInAnimation> createState() => _FlyInAnimationState();
}

class _FlyInAnimationState extends State<FlyInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    double begin = 0, end = 0;
    final flip = Random().nextBool();
    if (flip) {
      begin = 1;
      end = 0;
    }

    _rotationAnimation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticInOut,
      ),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FlyInAnimation oldWidget) {
    if (widget.animate && !_controller.isAnimating) {
      _controller.reset();
      _controller.forward();
      widget.animationCompleted?.call();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: (widget.removeScale ?? false)
          ? widget.child
          : ScaleTransition(scale: _controller, child: widget.child),
    );
  }
}
