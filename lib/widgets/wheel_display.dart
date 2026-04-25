import 'package:flutter/material.dart';
import '../utils/theme.dart';

/// 单个轮盘显示组件
class WheelDisplay extends StatelessWidget {
  final int number;
  final int index; // 0, 1, 2 表示第一、第二、第三个轮
  final bool isRolling;

  const WheelDisplay({
    super.key,
    required this.number,
    required this.index,
    this.isRolling = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '第${index + 1}轮',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 80,
          height: 80,
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
            child: isRolling
                ? _buildRollingIndicator()
                : Text(
                    number > 0 ? '$number' : '?',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: number > 0
                          ? AppTheme.wheelColor
                          : Colors.grey[400],
                    ),
                  ),
          ),
        ),
        if (number > 0) ...[
          const SizedBox(height: 4),
          Text(
            _getChineseNumber(number),
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.wheelColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRollingIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.wheelColor),
          ),
        ),
        const Icon(
          Icons.sync,
          size: 30,
          color: AppTheme.wheelColor,
        ),
      ],
    );
  }

  String _getChineseNumber(int number) {
    const chinese = ['', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十',
                     '十一', '十二', '十三', '十四', '十五', '十六', '十七', '十八'];
    if (number >= 0 && number <= 18) return chinese[number];
    return '$number';
  }
}

/// 轮盘组显示
class WheelGroupDisplay extends StatelessWidget {
  final int number1;
  final int number2;
  final int number3;
  final bool isRolling;

  const WheelGroupDisplay({
    super.key,
    required this.number1,
    required this.number2,
    required this.number3,
    this.isRolling = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        WheelDisplay(number: number1, index: 0, isRolling: isRolling),
        const SizedBox(width: 16),
        WheelDisplay(number: number2, index: 1, isRolling: isRolling),
        const SizedBox(width: 16),
        WheelDisplay(number: number3, index: 2, isRolling: isRolling),
      ],
    );
  }
}
