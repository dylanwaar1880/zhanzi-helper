import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/zhanzi_provider.dart';
import '../utils/theme.dart';
import '../../data_models/she_wen.dart';

/// 设问管理页面
class SheWenScreen extends StatefulWidget {
  const SheWenScreen({super.key});

  @override
  State<SheWenScreen> createState() => _SheWenScreenState();
}

class _SheWenScreenState extends State<SheWenScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _newSheWenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _newSheWenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设问管理'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '我的模板'),
            Tab(text: '预设模板'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyTemplates(),
          _buildPresetTemplates(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMyTemplates() {
    return Consumer<ZhanziProvider>(
      builder: (context, provider, _) {
        final templates = provider.sheWenTemplates;

        if (templates.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  '暂无自定义模板',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '点击右下角按钮添加',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: templates.length,
          itemBuilder: (context, index) {
            final template = templates[index];
            return _buildTemplateTile(template, provider, isPreset: false);
          },
        );
      },
    );
  }

  Widget _buildPresetTemplates() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: PresetSheWen.templates.length,
      itemBuilder: (context, index) {
        final template = SheWen.create(PresetSheWen.templates[index]);
        return _buildTemplateTile(template, null, isPreset: true);
      },
    );
  }

  Widget _buildTemplateTile(
    SheWen template,
    ZhanziProvider? provider, {
    required bool isPreset,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.wheelColor.withAlpha(26),
          child: Icon(
            isPreset ? Icons.auto_awesome : Icons.bookmark,
            color: AppTheme.wheelColor,
            size: 20,
          ),
        ),
        title: Text(
          template.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: isPreset
            ? null
            : Text(
                '使用${template.useCount}次',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
        trailing: isPreset
            ? null
            : PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    _confirmDelete(template, provider!);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('删除'),
                      ],
                    ),
                  ),
                ],
              ),
        onTap: () {
          if (isPreset) {
            // 使用预设模板
            Navigator.pop(context, template.content);
          } else {
            // 使用自定义模板
            Navigator.pop(context, template.content);
          }
        },
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加设问模板'),
        content: TextField(
          controller: _newSheWenController,
          decoration: const InputDecoration(
            hintText: '请输入设问内容...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _newSheWenController.clear();
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_newSheWenController.text.trim().isNotEmpty) {
                final provider =
                    Provider.of<ZhanziProvider>(context, listen: false);
                provider.addSheWenTemplate(_newSheWenController.text.trim());
                _newSheWenController.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('模板已添加')),
                );
              }
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(SheWen template, ZhanziProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除确认'),
        content: Text('确定要删除模板"${template.content}"吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.deleteSheWenTemplate(template.id!);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('模板已删除')),
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
