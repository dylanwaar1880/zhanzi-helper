import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/zhanzi_provider.dart';
import '../../data_models/zhanzi_record.dart';
import '../../data_models/lunxiang_data.dart';
import '../utils/helpers.dart';

/// 历史记录界面
class HistoryScreenV2 extends StatefulWidget {
  const HistoryScreenV2({super.key});

  @override
  State<HistoryScreenV2> createState() => _HistoryScreenV2State();
}

class _HistoryScreenV2State extends State<HistoryScreenV2> {
  String _filterType = 'all'; // all, favorite, auspicious, inauspicious

  @override
  void initState() {
    super.initState();
    // 加载历史记录
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ZhanziProvider>(context, listen: false).loadRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('历史记录'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                _showClearConfirmDialog();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Text('清空历史'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 筛选标签
          _buildFilterChips(),

          // 历史记录列表
          Expanded(
            child: Consumer<ZhanziProvider>(
              builder: (context, provider, child) {
                final records = _getFilteredRecords(provider);
                
                if (records.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    return _buildRecordCard(records[index], provider);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 构建筛选标签
  Widget _buildFilterChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _buildFilterChip('全部', 'all'),
          const SizedBox(width: 8),
          _buildFilterChip('收藏', 'favorite'),
          const SizedBox(width: 8),
          _buildFilterChip('吉兆', 'auspicious'),
          const SizedBox(width: 8),
          _buildFilterChip('需谨慎', 'inauspicious'),
        ],
      ),
    );
  }

  /// 构建筛选按钮
  Widget _buildFilterChip(String label, String type) {
    final isSelected = _filterType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _filterType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF8C00) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  /// 获取筛选后的记录
  List<ZhanziRecord> _getFilteredRecords(ZhanziProvider provider) {
    switch (_filterType) {
      case 'favorite':
        return provider.records.where((r) => r.isFavorite).toList();
      case 'auspicious':
        return provider.records.where((r) {
          final lunxiang = getLunxiangById(r.lunxiangId);
          return lunxiang?.isAuspicious ?? true;
        }).toList();
      case 'inauspicious':
        return provider.records.where((r) {
          final lunxiang = getLunxiangById(r.lunxiangId);
          return !(lunxiang?.isAuspicious ?? true);
        }).toList();
      default:
        return provider.records;
    }
  }

  /// 构建空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无历史记录',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建记录卡片
  Widget _buildRecordCard(ZhanziRecord record, ZhanziProvider provider) {
    final lunxiang = getLunxiangById(record.lunxiangId);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => _showRecordDetail(record),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部：时间 + 收藏按钮
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    Helpers.formatDateTime(record.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => provider.toggleFavorite(record.id!),
                    child: Icon(
                      record.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: record.isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // 设问内容
              if (record.sheWen.isNotEmpty) ...[
                Text(
                  record.sheWen,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
              ],

              // 数字和结果
              Row(
                children: [
                  // 三个数字
                  _buildNumberBadge(record.number1),
                  const Text(' + ', style: TextStyle(fontSize: 12)),
                  _buildNumberBadge(record.number2),
                  const Text(' + ', style: TextStyle(fontSize: 12)),
                  _buildNumberBadge(record.number3),
                  const Text(' = ', style: TextStyle(fontSize: 12)),
                  // 总和
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C00),
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
                  // 轮相结果
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (lunxiang?.isAuspicious ?? true)
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: (lunxiang?.isAuspicious ?? true)
                            ? Colors.green
                            : Colors.red,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      lunxiang?.name ?? '未知',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: (lunxiang?.isAuspicious ?? true)
                            ? Colors.green
                            : Colors.red,
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

  /// 构建数字徽章
  Widget _buildNumberBadge(int number) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFFF8C00).withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFFF8C00),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF8C00),
          ),
        ),
      ),
    );
  }

  /// 显示记录详情
  void _showRecordDetail(ZhanziRecord record) {
    final lunxiang = getLunxiangById(record.lunxiangId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '占察详情',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const Divider(),

            // 时间
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 8),
                Text(
                  Helpers.formatDateTime(record.createdAt),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 设问
            if (record.sheWen.isNotEmpty) ...[
              const Text(
                '设问内容',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(record.sheWen),
              ),
              const SizedBox(height: 16),
            ],

            // 结果
            const Text(
              '占察结果',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberBadge(record.number1),
                const Text(' + ', style: TextStyle(fontSize: 16)),
                _buildNumberBadge(record.number2),
                const Text(' + ', style: TextStyle(fontSize: 16)),
                _buildNumberBadge(record.number3),
                const Text(' = ', style: TextStyle(fontSize: 16)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C00),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${record.sum}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 轮相解释
            if (lunxiang != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: (lunxiang.isAuspicious ? Colors.green : Colors.red).shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: lunxiang.isAuspicious ? Colors.green : Colors.red,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: lunxiang.isAuspicious ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '第${lunxiang.id}号',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          lunxiang.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      lunxiang.summary,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: lunxiang.isAuspicious ? Colors.green.shade700 : Colors.red.shade700,
                      ),
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

            const SizedBox(height: 20),

            // 操作按钮
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<ZhanziProvider>(context, listen: false)
                          .toggleFavorite(record.id!);
                    },
                    icon: Icon(
                      record.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: record.isFavorite ? Colors.red : null,
                    ),
                    label: Text(record.isFavorite ? '取消收藏' : '收藏'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmDelete(record),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text('删除', style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 确认删除
  void _confirmDelete(ZhanziRecord record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这条记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Provider.of<ZhanziProvider>(context, listen: false)
                  .deleteRecord(record.id!);
            },
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// 显示清空确认对话框
  void _showClearConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清空历史'),
        content: const Text('确定要清空所有历史记录吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // 清空历史记录
              final provider = Provider.of<ZhanziProvider>(context, listen: false);
              for (var record in provider.records) {
                if (record.id != null) {
                  provider.deleteRecord(record.id!);
                }
              }
            },
            child: const Text('清空', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
