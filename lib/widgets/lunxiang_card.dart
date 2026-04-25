import 'package:flutter/material.dart';
import '../../data_models/lunxiang_data.dart';
import '../utils/theme.dart';
import '../utils/helpers.dart';

/// 轮相卡片组件
class LunxiangCard extends StatelessWidget {
  final Lunxiang lunxiang;
  final VoidCallback? onTap;
  final bool showFullDescription;

  const LunxiangCard({
    super.key,
    required this.lunxiang,
    this.onTap,
    this.showFullDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: lunxiang.isAuspicious
              ? AppTheme.auspiciousColor.withAlpha(77)
              : AppTheme.inauspiciousColor.withAlpha(77),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题行
              Row(
                children: [
                  // 编号标签
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: lunxiang.isAuspicious
                          ? AppTheme.auspiciousColor
                          : AppTheme.inauspiciousColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${lunxiang.id}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 名称
                  Expanded(
                    child: Text(
                      lunxiang.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // 吉祥/凶险图标
                  Icon(
                    lunxiang.isAuspicious
                        ? Icons.thumb_up
                        : Icons.warning,
                    color: lunxiang.isAuspicious
                        ? AppTheme.auspiciousColor
                        : AppTheme.inauspiciousColor,
                    size: 20,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // 分类标签
              Row(
                children: [
                  Icon(
                    Helpers.getLunxiangIcon(lunxiang.category),
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    lunxiang.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 简要说明
              Text(
                lunxiang.summary,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: lunxiang.isAuspicious
                      ? Colors.green[700]
                      : Colors.red[700],
                ),
              ),

              if (showFullDescription) ...[
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Text(
                  lunxiang.description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// 轮相列表项（简化版，用于搜索结果）
class LunxiangListTile extends StatelessWidget {
  final Lunxiang lunxiang;
  final VoidCallback? onTap;

  const LunxiangListTile({
    super.key,
    required this.lunxiang,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
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
      trailing: Icon(
        lunxiang.isAuspicious
            ? Icons.thumb_up_outlined
            : Icons.warning_outlined,
        color: lunxiang.isAuspicious
            ? AppTheme.auspiciousColor
            : AppTheme.inauspiciousColor,
        size: 20,
      ),
    );
  }
}
