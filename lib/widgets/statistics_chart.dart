import 'package:flutter/material.dart';
import '../../data_models/lunxiang_data.dart';
import '../utils/theme.dart';

/// 统计图表组件
class StatisticsChart extends StatelessWidget {
  final Map<int, int> distribution;
  final int totalCount;

  const StatisticsChart({
    super.key,
    required this.distribution,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    if (distribution.isEmpty) {
      return const Center(
        child: Text(
          '暂无统计数据',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // 获取最常出现的轮相
    final sortedEntries = distribution.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topEntries = sortedEntries.take(10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 总计数
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.wheelColor.withAlpha(26),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.auto_graph,
                      color: AppTheme.wheelColor,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '总占察次数',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '$totalCount',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.wheelColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // 吉祥/凶险比例
        _buildRatioCard(),

        const SizedBox(height: 16),

        // 最常出现的轮相
        const Text(
          '最常出现的轮相',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...topEntries.map((entry) {
          final lunxiang = getLunxiangById(entry.key);
          final percentage = (entry.value / totalCount * 100).toStringAsFixed(1);
          return _buildTopItem(lunxiang, entry.value, percentage);
        }),
      ],
    );
  }

  Widget _buildRatioCard() {
    int auspiciousCount = 0;
    int inauspiciousCount = 0;

    for (final entry in distribution.entries) {
      final lunxiang = getLunxiangById(entry.key);
      if (lunxiang?.isAuspicious ?? true) {
        auspiciousCount += entry.value;
      } else {
        inauspiciousCount += entry.value;
      }
    }

    final total = auspiciousCount + inauspiciousCount;
    final auspiciousRatio = total > 0 ? auspiciousCount / total : 0.5;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '吉祥/凶险比例',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: (auspiciousRatio * 100).toInt(),
                  child: Container(
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppTheme.auspiciousColor,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$auspiciousCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: ((1 - auspiciousRatio) * 100).toInt(),
                  child: Container(
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppTheme.inauspiciousColor,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$inauspiciousCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '吉祥 ${(auspiciousRatio * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: AppTheme.auspiciousColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '凶险 ${((1 - auspiciousRatio) * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: AppTheme.inauspiciousColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopItem(Lunxiang? lunxiang, int count, String percentage) {
    if (lunxiang == null) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        dense: true,
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: lunxiang.isAuspicious
                ? AppTheme.auspiciousColor.withAlpha(26)
                : AppTheme.inauspiciousColor.withAlpha(26),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${lunxiang.id}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: lunxiang.isAuspicious
                    ? AppTheme.auspiciousColor
                    : AppTheme.inauspiciousColor,
              ),
            ),
          ),
        ),
        title: Text(
          lunxiang.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          lunxiang.summary,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$count次',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
