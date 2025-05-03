import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OptimizedLottie extends StatefulWidget {
  const OptimizedLottie({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.animate = true,
    this.repeat = true,
    this.reverse = false,
    this.onLoaded,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool animate;
  final bool repeat;
  final bool reverse;
  final Function(LottieComposition)? onLoaded;

  @override
  State<OptimizedLottie> createState() => _OptimizedLottieState();
}

class _OptimizedLottieState extends State<OptimizedLottie> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    
    if (widget.repeat) {
      _controller!.repeat(reverse: widget.reverse);
    } else {
      _controller!.forward();
    }
    
    // Initially pause animation if not visible or not animate
    if (!widget.animate || !_isVisible) {
      _controller!.stop();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Add visibility listener
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isCurrentlyVisible = _isWidgetVisible();
      if (isCurrentlyVisible != _isVisible) {
        setState(() {
          _isVisible = isCurrentlyVisible;
        });
        _updateAnimationState();
      }
    });
  }

  @override
  void didUpdateWidget(OptimizedLottie oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle animate property changes
    if (widget.animate != oldWidget.animate) {
      _updateAnimationState();
    }
    
    // Handle repeat property changes
    if (widget.repeat != oldWidget.repeat) {
      if (widget.repeat) {
        _controller!.repeat(reverse: widget.reverse);
      } else {
        _controller!.forward();
      }
    }
  }

  bool _isWidgetVisible() {
    // Simple check if widget is in a route that's visible
    return ModalRoute.of(context)?.isCurrent ?? false;
  }

  void _updateAnimationState() {
    if (widget.animate && _isVisible) {
      if (widget.repeat) {
        _controller!.repeat(reverse: widget.reverse);
      } else if (_controller!.status != AnimationStatus.completed) {
        _controller!.forward();
      }
    } else {
      _controller!.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update visibility status
    final isCurrentlyVisible = _isWidgetVisible();
    if (isCurrentlyVisible != _isVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isVisible = isCurrentlyVisible;
        });
        _updateAnimationState();
      });
    }

    return Lottie.asset(
      widget.assetPath,
      controller: _controller,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      onLoaded: (composition) {
        // Update controller duration to match composition
        _controller!.duration = composition.duration;
        if (widget.onLoaded != null) {
          widget.onLoaded!(composition);
        }
        _updateAnimationState();
      },
    );
  }
} 