import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/zhanzi_provider.dart';
import '../widgets/wheel_display.dart';
import '../widgets/wheel_animation.dart';
import '../widgets/result_display.dart';
import '../widgets/number_grid.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import '../../data_models/lunxiang_data.dart';

/// 占察主界面
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _sheWenController = TextEditingController();
  final FocusNode _sheWenFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ZhanziProvider>(context, listen: false);
      _sheWenController.text = provider.sheWen;
    });
  }

  @override
  void dispose() {
    _sheWenController.dispose();
    _sheWenFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/history'),
            tooltip: '历史记录',
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => Navigator.pushNamed(context, '/lunxiang'),
            tooltip: '轮相查询',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            tooltip: '设置',
          ),
        ],
      ),
      body: Consumer<ZhanziProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 设问输入区
                _buildSheWenInput(provider),

                const SizedBox(height: 24),

                // 轮盘区域
                _buildWheelArea(provider),

                const SizedBox(height: 24),

                // 操作按钮
                _buildActionButtons(provider),

                const SizedBox(height: 24),

                // 结果显示
                if (provider.hasResult)
                  ResultDisplay(
                    lunxiang: provider.currentLunxiang,
                    number1: provider.number1,
                    number2: provider.number2,
                    number3: provider.number3,
                    sum: provider.sum,
                  ),

                const SizedBox(height: 80), // 底部留白
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSheWenInput(ZhanziProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.help_outline, color: AppTheme.wheelColor),
                const SizedBox(width: 8),
                const Text(
                  '设问',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _showSheWenPicker(provider),
                  icon: const Icon(Icons.book, size: 16),
                  label: const Text('常用'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sheWenController,
              focusNode: _sheWenFocus,
              decoration: InputDecoration(
                hintText: '请输入您想要占察的问题...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: _sheWenController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _sheWenController.clear();
                          provider.setSheWen('');
                        },
                      )
                    : null,
              ),
              maxLines: 2,
              onChanged: (value) {
                provider.setSheWen(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWheelArea(ZhanziProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              '掷占察轮',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              provider.isRolling ? '掷轮中...' : '点击下方按钮开始占察',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),

            // 轮盘显示
            if (provider.isRolling)
              WheelAnimationGroup(
                target1: provider.number1,
                target2: provider.number2,
                target3: provider.number3,
                isRolling: true,
                onAllComplete: () {
                  provider.completeRolling();
                },
              )
            else if (provider.hasResult)
              WheelGroupDisplay(
                number1: provider.number1,
                number2: provider.number2,
                number3: provider.number3,
              )
            else
              _buildIdleWheel(),

            const SizedBox(height: 24),

            // 数字网格
            if (provider.hasResult) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMiniGrid(1, provider.number1, provider.isRolling),
                  const SizedBox(width: 8),
                  _buildMiniGrid(2, provider.number2, provider.isRolling),
                  const SizedBox(width: 8),
                  _buildMiniGrid(3, provider.number3, provider.isRolling),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIdleWheel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return Column(
          children: [
            Text(
              '第${index + 1}轮',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppTheme.wheelBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.wheelColor.withAlpha(128),
                  width: 3,
                ),
              ),
              child: const Center(
                child: Text(
                  '?',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMiniGrid(int wheelIndex, int currentNumber, bool isRolling) {
    final numbers = List.generate(18, (i) => i + 1);
    return Container(
      width: 80,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.wheelBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.wheelColor.withAlpha(128)),
      ),
      child: Column(
        children: [
          Text(
            '第$wheelIndex轮',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 6,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            physics: const NeverScrollableScrollPhysics(),
            children: numbers.map((n) {
              final isHighlighted = n == currentNumber;
              return Container(
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? AppTheme.wheelColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: Text(
                    '$n',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight:
                          isHighlighted ? FontWeight.bold : FontWeight.normal,
                      color: isHighlighted ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ZhanziProvider provider) {
    if (provider.isRolling) {
      return const SizedBox.shrink();
    }

    if (provider.hasResult) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                provider.nextRound();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('下一把'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                provider.newQuestion();
                _sheWenController.clear();
              },
              icon: const Icon(Icons.add),
              label: const Text('新设问'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      );
    }

    return ElevatedButton.icon(
      onPressed: _sheWenController.text.isEmpty
          ? null
          : () async {
              provider.setSheWen(_sheWenController.text);
              await provider.startRolling();
            },
      icon: const Icon(Icons.play_arrow),
      label: const Text('开始掷轮'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.wheelColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showSheWenPicker(ZhanziProvider provider) {
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
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    '选择设问',
                    style: TextStyle(
                      fontSize: 18,
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
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  // 预设模板
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '预设模板',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ...PresetSheWen.templates.map((template) => ListTile(
                        title: Text(template),
                        onTap: () {
                          _sheWenController.text = template;
                          provider.setSheWen(template);
                          Navigator.pop(context);
                        },
                      )),
                  // 历史设问
                  if (provider.records.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '历史设问',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    ...provider.records
                        .where((r) => r.sheWen.isNotEmpty)
                        .take(10)
                        .map((record) => ListTile(
                              title: Text(record.sheWen),
                              subtitle: Text(
                                '${record.number1}+${record.number2}+${record.number3}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              onTap: () {
                                _sheWenController.text = record.sheWen;
                                provider.setSheWen(record.sheWen);
                                Navigator.pop(context);
                              },
                            )),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
