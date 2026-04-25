import 'package:flutter/material.dart';
import '../../data_models/lunxiang_data.dart';
import '../widgets/lunxiang_card.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';

/// 轮相查询列表页面
class LunxiangListScreen extends StatefulWidget {
  const LunxiangListScreen({super.key});

  @override
  State<LunxiangListScreen> createState() => _LunxiangListScreenState();
}

class _LunxiangListScreenState extends State<LunxiangListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Lunxiang> get _filteredList {
    var list = lunxiangList;

    // 按分类筛选
    if (_selectedCategory != null) {
      list = list.where((l) => l.category == _selectedCategory).toList();
    }

    // 按搜索词筛选
    if (_searchQuery.isNotEmpty) {
      list = list.where((l) {
        return l.name.contains(_searchQuery) ||
            l.summary.contains(_searchQuery) ||
            l.description.contains(_searchQuery) ||
            '${l.id}'.contains(_searchQuery);
      }).toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('轮相查询'),
      ),
      body: Column(
        children: [
          // 搜索栏
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索轮相名称、编号或内容...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // 分类筛选
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildCategoryChip(null, '全部'),
                ...LunxiangCategories.all.map(
                  (cat) => _buildCategoryChip(cat, cat),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 结果统计
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '共 ${_filteredList.length} 种轮相',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 轮相列表
          Expanded(
            child: _filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '未找到匹配的轮相',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: _filteredList.length,
                    itemBuilder: (context, index) {
                      final lunxiang = _filteredList[index];
                      return LunxiangCard(
                        lunxiang: lunxiang,
                        onTap: () => _showDetail(lunxiang),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String? category, String label) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? category : null;
          });
        },
        selectedColor: AppTheme.wheelColor.withAlpha(51),
        checkmarkColor: AppTheme.wheelColor,
      ),
    );
  }

  void _showDetail(Lunxiang lunxiang) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LunxiangDetailScreen(lunxiang: lunxiang),
      ),
    );
  }
}

/// 轮相详情页面
class LunxiangDetailScreen extends StatelessWidget {
  final Lunxiang lunxiang;

  const LunxiangDetailScreen({
    super.key,
    required this.lunxiang,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第${lunxiang.id}号轮相'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // 分享功能
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('分享功能开发中')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 头部卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 编号和吉祥标识
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: lunxiang.isAuspicious
                                ? AppTheme.auspiciousColor
                                : AppTheme.inauspiciousColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '第${lunxiang.id}号',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: lunxiang.isAuspicious
                                ? AppTheme.auspiciousColor.withAlpha(26)
                                : AppTheme.inauspiciousColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: lunxiang.isAuspicious
                                  ? AppTheme.auspiciousColor
                                  : AppTheme.inauspiciousColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                lunxiang.isAuspicious
                                    ? Icons.thumb_up
                                    : Icons.warning,
                                size: 16,
                                color: lunxiang.isAuspicious
                                    ? AppTheme.auspiciousColor
                                    : AppTheme.inauspiciousColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                lunxiang.isAuspicious ? '吉祥' : '需谨慎',
                                style: TextStyle(
                                  color: lunxiang.isAuspicious
                                      ? AppTheme.auspiciousColor
                                      : AppTheme.inauspiciousColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 名称
                    Text(
                      lunxiang.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // 分类
                    Chip(
                      avatar: Icon(
                        Icons.category,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      label: Text(lunxiang.category),
                      backgroundColor: Colors.grey[100],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 简要说明
            Card(
              color: lunxiang.isAuspicious
                  ? Colors.green.shade50
                  : Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lightbulb_outline),
                        SizedBox(width: 8),
                        Text(
                          '简要说明',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      lunxiang.summary,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: lunxiang.isAuspicious
                            ? Colors.green[800]
                            : Colors.red[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 详细解释
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.description),
                        SizedBox(width: 8),
                        Text(
                          '详细解释',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      lunxiang.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 相关操作
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.refresh),
                    title: const Text('以此为设问占察'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pop(context);
                      // 可以添加导航到占察界面并使用此轮相
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
