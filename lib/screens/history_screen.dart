import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/zhanzi_provider.dart';
import '../widgets/record_tile.dart';
import '../widgets/statistics_chart.dart';
import '../utils/theme.dart';

/// 历史记录页面
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('历史记录'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '记录列表'),
            Tab(text: '数据统计'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              final provider =
                  Provider.of<ZhanziProvider>(context, listen: false);
              provider.setFilter(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('全部记录'),
              ),
              const PopupMenuItem(
                value: 'favorite',
                child: Text('仅收藏'),
              ),
              const PopupMenuItem(
                value: 'auspicious',
                child: Text('仅吉祥'),
              ),
              const PopupMenuItem(
                value: 'inauspicious',
                child: Text('仅需谨慎'),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<ZhanziProvider>(
        builder: (context, provider, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildRecordList(provider),
              _buildStatistics(provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecordList(ZhanziProvider provider) {
    final records = provider.getFilteredRecords();

    if (records.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '暂无历史记录',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '开始您的第一次占察吧',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.loadRecords(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return RecordTile(
            record: record,
            onTap: () => _showRecordDetail(record, provider),
            onFavoriteToggle: () =>
                provider.toggleFavorite(record.id!),
            onDelete: () => _confirmDelete(record, provider),
          );
        },
      ),
    );
  }

  Widget _buildStatistics(ZhanziProvider provider) {
    return FutureBuilder<Map<String, int>>(
      future: provider.getStatistics(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final stats = snapshot.data!;
        final distribution = <int, int>{};
        
        // 从stats中提取轮相分布
        for (final entry in stats.entries) {
          final key = entry.key;
          if (key is int && key >= 1 && key <= 189) {
            distribution[key] = entry.value;
          }
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: StatisticsChart(
            distribution: distribution,
            totalCount: stats['totalCount'] ?? 0,
          ),
        );
      },
    );
  }

  void _showRecordDetail(record, ZhanziProvider provider) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => RecordDetailDialog(record: record),
    );

    if (result == 'favorite') {
      await provider.toggleFavorite(record.id!);
    } else if (result == 'unfavorite') {
      await provider.toggleFavorite(record.id!);
    }
  }

  void _confirmDelete(record, ZhanziProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除确认'),
        content: const Text('确定要删除这条记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.deleteRecord(record.id!);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('记录已删除')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
