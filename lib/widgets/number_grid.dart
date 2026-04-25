import 'package:flutter/material.dart';
import '../utils/theme.dart';

/// 数字网格组件
/// 显示3×6的数字网格，高亮当前数字
class NumberGrid extends StatelessWidget {
  final int currentNumber;
  final int highlightedNumber;
  final bool isHighlighted;

  const NumberGrid({
    super.key,
    required this.currentNumber,
    this.highlightedNumber = 0,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.wheelBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.wheelColor.withAlpha(128),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildRows(),
      ),
    );
  }

  List<Widget> _buildRows() {
    final rows = <Widget>[];
    for (int row = 0; row < 6; row++) {
      final rowWidgets = <Widget>[];
      for (int col = 0; col < 3; col++) {
        final number = row * 3 + col + 1;
        rowWidgets.add(
          Expanded(
            child: _buildCell(number),
          ),
        );
      }
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: rowWidgets,
          ),
        ),
      );
    }
    return rows;
  }

  Widget _buildCell(int number) {
    final isCurrentNumber = isHighlighted && number == highlightedNumber;
    final isDisplayNumber = !isHighlighted && number == currentNumber;

    Color bgColor;
    Color textColor;

    if (isCurrentNumber || isDisplayNumber) {
      bgColor = AppTheme.wheelColor;
      textColor = Colors.white;
    } else {
      bgColor = Colors.transparent;
      textColor = AppTheme.primaryTextColor;
    }

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

/// 简化的数字网格（只显示当前数字）
class SimpleNumberDisplay extends StatelessWidget {
  final int number;
  final bool isRolling;

  const SimpleNumberDisplay({
    super.key,
    required this.number,
    this.isRolling = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isRolling ? AppTheme.wheelColor.withAlpha(128) : AppTheme.wheelColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.wheelColor.withAlpha(77),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          number > 0 ? '$number' : '?',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
