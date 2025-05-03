// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

class OptimizedLottiePlayer extends StatefulWidget {
  const OptimizedLottiePlayer({
    Key? key,
    this.width,
    this.height,
    required this.assetPath,
    this.fit = BoxFit.cover,
    this.animate = true,
    this.reverse = false,
    this.repeat = true,
    this.frameRate = 60,
    this.opacity = 1.0,
    this.visibilityThreshold = 0.1, // Only play when at least 10% visible
    this.preloadAssets = true,      // Whether to preload animation assets
  }) : super(key: key);

  final double? width;
  final double? height;
  final String assetPath;
  final BoxFit fit;
  final bool animate;
  final bool reverse;
  final bool repeat;
  final double frameRate;
  final double opacity;
  final double visibilityThreshold;
  final bool preloadAssets;

  @override
  State<OptimizedLottiePlayer> createState() => _OptimizedLottiePlayerState();
}

class _OptimizedLottiePlayerState extends State<OptimizedLottiePlayer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isVisible = false;
  String _widgetId = UniqueKey().toString();
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Will be updated when Lottie loads
    );
    
    // Preload animation asset if enabled
    if (widget.preloadAssets) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // Pre-cache the Lottie file in memory
        precacheLottie();
      });
    }
  }
  
  void precacheLottie() {
    // This forces the asset to be loaded into memory
    AssetLottie(widget.assetPath).load();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(OptimizedLottiePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle changes to animation controls
    if (widget.animate != oldWidget.animate ||
        widget.repeat != oldWidget.repeat ||
        widget.reverse != oldWidget.reverse) {
      _updateAnimationState();
    }
  }
  
  void _updateAnimationState() {
    if (!_isVisible || !widget.animate) {
      _animationController.stop();
      return;
    }
    
    if (widget.repeat) {
      if (widget.reverse) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.repeat();
      }
    } else if (!_animationController.isAnimating) {
      _animationController.forward();
    }
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    final bool wasVisible = _isVisible;
    _isVisible = info.visibleFraction > widget.visibilityThreshold;
    
    // Only update if visibility changed
    if (wasVisible != _isVisible) {
      if (_isVisible) {
        _updateAnimationState();
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(_widgetId),
      onVisibilityChanged: _handleVisibilityChanged,
      child: Opacity(
        opacity: widget.opacity,
        child: Lottie.asset(
          widget.assetPath,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          controller: _animationController,
          frameRate: FrameRate(widget.frameRate),
          repeat: false, // We handle repeat manually for better control
          onLoaded: (composition) {
            // Update controller duration to match the animation duration
            _animationController.duration = composition.duration;
            _updateAnimationState();
          },
        ),
      ),
    );
  }
} 