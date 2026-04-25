import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';

/// 掷轮动画组件
class WheelAnimation extends StatefulWidget {
  final int targetNumber;
  final VoidCallback? onComplete;
  final bool isRolling;

  const WheelAnimation({
    super.key,
    required this.targetNumber,
    this.onComplete,
    this.isRolling = false,
  });

  @override
  State<WheelAnimation> createState() => _WheelAnimationState();
}

class _WheelAnimationState extends State<WheelAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _displayNumber = 0;
  Timer? _timer;
  final Random _random = Random();
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: AppConstants.rollAnimationDuration,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _displayNumber = widget.targetNumber;
          _isAnimating = false;
        });
        widget.onComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(WheelAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRolling && !_isAnimating) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    setState(() {
      _isAnimating = true;
      _displayNumber = _random.nextInt(18) + 1;
    });

    // 开始快速切换数字
    _startNumberChange();

    // 动画控制器
    _controller.forward(from: 0);
  }

  void _startNumberChange() {
    int interval = AppConstants.numberChangeInterval;
    int changeCount = 0;
    const maxChanges = 40;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (!_isAnimating) {
        timer.cancel();
        return;
      }

      setState(() {
        _displayNumber = _random.nextInt(18) + 1;
      });

      changeCount++;

      // 逐渐放慢
      if (changeCount > maxChanges ~/ 2) {
        interval = AppConstants.numberChangeInterval *
            AppConstants.numberChangeSlowdownFactor;
        timer.cancel();
        _startSlowChange(interval);
      }
    });
  }

  void _startSlowChange(int interval) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (!_isAnimating) {
        timer.cancel();
        return;
      }

      // 越接近目标数字，概率越高
      final diff = (_displayNumber - widget.targetNumber).abs();
      if (diff == 0 || (diff <= 2 && _random.nextDouble() > 0.5)) {
        timer.cancel();
        setState(() {
          _displayNumber = widget.targetNumber;
          _isAnimating = false;
        });
        widget.onComplete?.call();
      } else {
        // 逐渐接近目标
        setState(() {
          if (_random.nextDouble() > 0.7) {
            _displayNumber = _displayNumber > widget.targetNumber
                ? _displayNumber - 1
                : _displayNumber + 1;
            if (_displayNumber < 1) _displayNumber = 1;
            if (_displayNumber > 18) _displayNumber = 18;
          } else {
            _displayNumber = _random.nextInt(18) + 1;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppTheme.wheelBackgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.wheelColor,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.wheelColor.withAlpha(51),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          _displayNumber > 0 ? '$_displayNumber' : '?',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: _isAnimating
                ? Colors.grey[400]
                : AppTheme.wheelColor,
          ),
        ),
      ),
    );
  }
}

/// 三个轮盘动画组
class WheelAnimationGroup extends StatefulWidget {
  final int target1;
  final int target2;
  final int target3;
  final VoidCallback? onAllComplete;
  final bool isRolling;

  const WheelAnimationGroup({
    super.key,
    required this.target1,
    required this.target2,
    required this.target3,
    this.onAllComplete,
    this.isRolling = false,
  });

  @override
  State<WheelAnimationGroup> createState() => _WheelAnimationGroupState();
}

class _WheelAnimationGroupState extends State<WheelAnimationGroup> {
  int _completedCount = 0;

  void _onOneComplete() {
    _completedCount++;
    if (_completedCount >= 3) {
      widget.onAllComplete?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        WheelAnimation(
          targetNumber: widget.target1,
          isRolling: widget.isRolling,
          onComplete: _onOneComplete,
        ),
        WheelAnimation(
          targetNumber: widget.target2,
          isRolling: widget.isRolling,
          onComplete: _onOneComplete,
        ),
        WheelAnimation(
          targetNumber: widget.target3,
          isRolling: widget.isRolling,
          onComplete: _onOneComplete,
        ),
      ],
    );
  }
}
