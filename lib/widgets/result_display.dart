import 'package:flutter/material.dart';
import '../../data_models/lunxiang_data.dart';
import '../utils/theme.dart';
import '../utils/helpers.dart';

/// 结果显示卡片组件
class ResultDisplay extends StatelessWidget {
  final Lunxiang? lunxiang;
  final int number1;
  final int number2;
  final int number3;
  final int sum;
  final bool showDetails;

  const ResultDisplay({
    super.key,
    required this.lunxiang,
    required this.number1,
    required this.number2,
    required this.number3,
    required this.sum,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    if (lunxiang == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: lunxiang!.isAuspicious
                ? [Colors.green.shade50, Colors.white]
                : [Colors.red.shade50, Colors.white],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 轮相编号和名称
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: lunxiang!.isAuspicious
                        ? AppTheme.auspiciousColor
                        : AppTheme.inauspiciousColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '第${lunxiang!.id}号',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  lunxiang!.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 三个数字和总和
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberChip(number1),
                const Text(' + ', style: TextStyle(fontSize: 20)),
                _buildNumberChip(number2),
                const Text(' + ', style: TextStyle(fontSize: 20)),
                _buildNumberChip(number3),
                const Text(' = ', style: TextStyle(fontSize: 20)),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.wheelColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$sum',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // 分类标签
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Helpers.getLunxiangIcon(lunxiang!.category),
                  size: 18,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  lunxiang!.category,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 简要说明
            Text(
              lunxiang!.summary,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: lunxiang!.isAuspicious
                    ? Colors.green[700]
                    : Colors.red[700],
              ),
              textAlign: TextAlign.center,
            ),

            if (showDetails) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),

              // 详细解释
              Text(
                lunxiang!.description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                ),
                textAlign: TextAlign.left,
              ),
            ],

            const SizedBox(height: 16),

            // 吉祥/凶险指示
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: lunxiang!.isAuspicious
                    ? AppTheme.auspiciousColor.withAlpha(26)
                    : AppTheme.inauspiciousColor.withAlpha(26),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: lunxiang!.isAuspicious
                      ? AppTheme.auspiciousColor
                      : AppTheme.inauspiciousColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    lunxiang!.isAuspicious
                        ? Icons.thumb_up
                        : Icons.warning,
                    size: 18,
                    color: lunxiang!.isAuspicious
                        ? AppTheme.auspiciousColor
                        : AppTheme.inauspiciousColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    lunxiang!.isAuspicious ? '吉兆' : '需谨慎',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: lunxiang!.isAuspicious
                          ? AppTheme.auspiciousColor
                          : AppTheme.inauspiciousColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberChip(int number) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppTheme.wheelColor.withAlpha(26),
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.wheelColor),
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.wheelColor,
          ),
        ),
      ),
    );
  }
}

/// 简化版结果显示（用于列表）
class SimpleResultDisplay extends StatelessWidget {
  final int number1;
  final int number2;
  final int number3;
  final int sum;
  final int lunxiangId;

  const SimpleResultDisplay({
    super.key,
    required this.number1,
    required this.number2,
    required this.number3,
    required this.sum,
    required this.lunxiangId,
  });

  @override
  Widget build(BuildContext context) {
    final lunxiang = getLunxiangById(lunxiangId);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '$number1 + $number2 + $number3 = $sum',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            lunxiang?.name ?? '未知',
            style: TextStyle(
              fontSize: 14,
              color: lunxiang?.isAuspicious ?? true
                  ? AppTheme.auspiciousColor
                  : AppTheme.inauspiciousColor,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
