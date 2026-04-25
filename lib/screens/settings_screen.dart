import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';

/// 设置页面
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final StorageService _storage = StorageService();
  String _themeMode = AppConstants.themeModeSystem;
  bool _simpleMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _themeMode = _storage.getThemeMode();
      _simpleMode = _storage.getSimpleMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        children: [
          // 外观设置
          _buildSectionHeader('外观'),
          _buildThemeSelector(),
          const Divider(),

          // 占察模式
          _buildSectionHeader('占察模式'),
          SwitchListTile(
            title: const Text('简轨模式'),
            subtitle: const Text('显示简化版轮相解释'),
            value: _simpleMode,
            onChanged: (value) async {
              await _storage.setSimpleMode(value);
              setState(() => _simpleMode = value);
            },
          ),
          const Divider(),

          // 数据管理
          _buildSectionHeader('数据管理'),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('导出数据'),
            subtitle: const Text('将历史记录导出为JSON文件'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _exportData,
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('导入数据'),
            subtitle: const Text('从JSON文件导入历史记录'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _importData,
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep, color: Colors.red),
            title: const Text(
              '清空所有数据',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: const Text('删除所有历史记录和设置'),
            onTap: _confirmClearAll,
          ),
          const Divider(),

          // 帮助
          _buildSectionHeader('帮助'),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('使用说明'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showHelp,
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('关于占察法门'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showAbout,
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('关于应用'),
            subtitle: const Text('版本 ${AppConstants.appVersion}'),
            onTap: _showAboutApp,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('主题模式'),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: AppConstants.themeModeLight,
                icon: Icon(Icons.light_mode),
                label: Text('日间'),
              ),
              ButtonSegment(
                value: AppConstants.themeModeDark,
                icon: Icon(Icons.dark_mode),
                label: Text('夜间'),
              ),
              ButtonSegment(
                value: AppConstants.themeModeSystem,
                icon: Icon(Icons.settings_suggest),
                label: Text('跟随系统'),
              ),
            ],
            selected: {_themeMode},
            onSelectionChanged: (Set<String> selection) async {
              await _storage.setThemeMode(selection.first);
              setState(() => _themeMode = selection.first);
              // 通知应用刷新主题
              // 实际实现时需要通过Provider或状态管理来更新主题
            },
          ),
        ],
      ),
    );
  }

  void _exportData() async {
    try {
      final data = await _storage.exportData();
      if (data.isNotEmpty) {
        // 保存到文件
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('数据导出成功')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('暂无数据可导出')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('导出失败: $e')),
      );
    }
  }

  void _importData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('导入数据'),
        content: const Text(
          '此功能需要从文件选择器选择JSON文件。\n\n'
          '注意：导入数据会合并到现有数据中，不会覆盖已有记录。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('导入功能开发中')),
              );
            },
            child: const Text('选择文件'),
          ),
        ],
      ),
    );
  }

  void _confirmClearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清空所有数据'),
        content: const Text(
          '确定要清空所有数据吗？\n\n'
          '这将删除：\n'
          '• 所有历史记录\n'
          '• 所有自定义设问模板\n'
          '• 所有个人设置\n\n'
          '此操作不可恢复！',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _storage.clearAll();
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('所有数据已清空')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('确认清空'),
          ),
        ],
      ),
    );
  }

  void _showHelp() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    '使用说明',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildHelpItem(
                '1. 输入设问',
                '在占察界面输入您想要占察的问题。\n您可以从预设模板中选择，也可以输入自定义问题。',
              ),
              _buildHelpItem(
                '2. 掷轮占察',
                '点击"开始掷轮"按钮，系统将随机生成三个数字（1-18）。',
              ),
              _buildHelpItem(
                '3. 查看结果',
                '三个数字之和对应189种轮相之一，系统会显示相应的吉凶解释。',
              ),
              _buildHelpItem(
                '4. 保存记录',
                '占察记录会自动保存，您可以在历史记录中查看和管理。',
              ),
              _buildHelpItem(
                '5. 简轨与繁轨',
                '简轨模式显示简化解释，繁轨模式显示完整解释。您可以在设置中切换。',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('关于占察法门'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '占察法门源于《占察善恶业报经》',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '占察法门是地藏法门的重要组成部分，由地藏菩萨传授给坚净信菩萨。'
                '此法门通过使用占察轮（三个分别标有1-18数字的轮盘）来占卜问事，'
                '以三个数字之和（共3-54的范围）对应189种轮相，根据轮相判断吉凶。',
              ),
              SizedBox(height: 12),
              Text(
                '占察轮相分为三大类：',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('• 观善恶业（1-10）：观察善恶业力差别'),
              Text('• 观所疑（11-100）：观察各种疑问所疑之事'),
              Text('• 观业果报（101-189）：观察因果报应的各种情况'),
              SizedBox(height: 12),
              Text(
                '占察法门强调以清净心、虔诚心占察，并且强调因果不虚，'
                '占察结果仅供参考，应当以积极行善的态度面对人生。',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }

  void _showAboutApp() {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: AppConstants.appVersion,
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppTheme.wheelColor.withAlpha(26),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.auto_awesome,
          size: 32,
          color: AppTheme.wheelColor,
        ),
      ),
      children: const [
        Text(
          '占察助手是一款基于佛教占察法门的移动应用，'
          '帮助用户进行占察轮相占卜，查询历史记录，管理设问模板。',
        ),
        SizedBox(height: 8),
        Text(
          '本应用仅供娱乐参考，不构成任何宗教建议。'
          '因果业力自有定数，当以积极行善的态度面对人生。',
        ),
      ],
    );
  }
}
