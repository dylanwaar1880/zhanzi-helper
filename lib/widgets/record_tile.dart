import 'package:flutter/material.dart';
import '../../data_models/zhanzi_record.dart';
import '../../data_models/lunxiang_data.dart';
import '../utils/theme.dart';
import '../utils/helpers.dart';

/// 历史记录列表项组件
class RecordTile extends StatelessWidget {
  final ZhanziRecord record;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onDelete;

  const RecordTile({
    super.key,
    required this.record,
    this.onTap,
    this.onFavoriteToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final lunxiang = getLunxiangById(record.lunxiangId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部行：时间和收藏按钮
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    Helpers.getRelativeTime(record.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(),
                  if (onFavoriteToggle != null)
                    IconButton(
                      onPressed: onFavoriteToggle,
                      icon: Icon(
                        record.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: record.isFavorite ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              // 设问内容
              if (record.sheWen.isNotEmpty) ...[
                Text(
                  record.sheWen,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],

              // 数字和轮相
              Row(
                children: [
                  // 三个数字
                  _buildNumberBadge(record.number1),
                  const Text(' + ', style: TextStyle(fontSize: 12)),
                  _buildNumberBadge(record.number2),
                  const Text(' + ', style: TextStyle(fontSize: 12)),
                  _buildNumberBadge(record.number3),
                  const Text(' = ', style: TextStyle(fontSize: 12)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.wheelColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${record.sum}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // 轮相名称
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: (lunxiang?.isAuspicious ?? true)
                          ? AppTheme.auspiciousColor.withAlpha(26)
                          : AppTheme.inauspiciousColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      lunxiang?.name ?? '未知',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: (lunxiang?.isAuspicious ?? true)
                            ? AppTheme.auspiciousColor
                            : AppTheme.inauspiciousColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberBadge(int number) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppTheme.wheelColor.withAlpha(26),
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.wheelColor, width: 1),
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppTheme.wheelColor,
          ),
        ),
      ),
    );
  }
}

/// 记录详情弹窗
class RecordDetailDialog extends StatelessWidget {
  final ZhanziRecord record;

  const RecordDetailDialog({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final lunxiang = getLunxiangById(record.lunxiangId);

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.history),
          const SizedBox(width: 8),
          const Text('占察记录详情'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 时间
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 8),
                Text(
                  Helpers.formatDateTime(record.createdAt),
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 设问
            if (record.sheWen.isNotEmpty) ...[
              const Text(
                '设问',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(record.sheWen),
              const SizedBox(height: 16),
            ],

            // 结果
            const Text(
              '占察结果',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$record.number1 + $record.number2 + $record.number3 = ${record.sum}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (lunxiang != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: lunxiang.isAuspicious
                                ? AppTheme.auspiciousColor
                                : AppTheme.inauspiciousColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '第${lunxiang.id}号 ${lunxiang.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lunxiang.description,
                      style: const TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: [
        if (record.isFavorite)
          TextButton.icon(
            onPressed: () => Navigator.pop(context, 'unfavorite'),
            icon: const Icon(Icons.favorite, color: Colors.red),
            label: const Text('取消收藏'),
          )
        else
          TextButton.icon(
            onPressed: () => Navigator.pop(context, 'favorite'),
            icon: const Icon(Icons.favorite_border),
            label: const Text('收藏'),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('关闭'),
        ),
      ],
    );
  }
}
