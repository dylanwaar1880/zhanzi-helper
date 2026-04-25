import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

/// 占察主界面 - 优化版
/// 分组逻辑：每三个数字为一组（1-3→0, 4-6→1, 7-9→2, 10-12→3, 13-15→4, 16-18→5）
/// 约束规则：已完成掷次不可更改
/// 新功能：同一设问只记录一次、实时保存、全屏历史页面
class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({super.key});

  @override
  State<HomeScreenV2> createState() => _HomeScreenV2State();
}

/// 1～189 地藏占察轮相数据
const Map<int, String> wheelData = {
  1:"求上乘得不退",2:"所求果现当证",3:"求中乘得不退",4:"求下乘得不退",
  5:"求神通得成就",6:"修四梵得成就",7:"修世禅得成就",8:"所欲受得妙戒",
  9:"所曾受得戒具",10:"求上乘未住信",11:"求中乘未住信",12:"求下乘未住信",
  13:"所观人为善友",14:"随所闻是正法",15:"所观人为恶友",16:"随所闻非正教",
  17:"所观人有实德",18:"所观人无实德",19:"所观义不错谬",20:"所观义是错谬",
  21:"有所诵不错谬",22:"有所诵是错谬",23:"所修行不错谬",24:"所见闻是善相",
  25:"有所证为真实",26:"有所学是错谬",27:"所见闻非善相",28:"有所证非正法",
  29:"有所获邪神持",30:"所能说邪智辩",31:"所玄知非人力",32:"应先习智道观",
  33:"应先习禅定道",34:"观所学无障碍",35:"观所学是所宜",36:"观所学非所宜",
  37:"观所学是宿习",38:"观所学非宿习",39:"观所学善增长",40:"观所学方便少",
  41:"观所学无进趣",42:"所求果现未得",43:"求出家当得去",44:"求闻法得教示",
  45:"求经卷得读诵",46:"观所作是魔事",47:"观所作事成就",48:"观所作事不成",
  49:"求大富财盈满",50:"求官位当得获",51:"求寿命得延年",52:"求世仙当得获",
  53:"观学问多所达",54:"观学问少所达",55:"求师友得如意",56:"求弟子得如意",
  57:"求父母得如意",58:"求男女得如意",59:"求妻妾得如意",60:"求同伴得如意",
  61:"观所虑得和合",62:"所观人心怀恚",63:"求无恨得欢喜",64:"求和合得如意",
  65:"所观人心欢喜",66:"所思人得会见",67:"所思人不复会",68:"所请唤得来集",
  69:"所憎恶得离之",70:"所爱敬得近之",71:"观欲聚得和集",72:"观欲聚不和集",
  73:"所请唤不得来",74:"所期人必当至",75:"所期人住不来",76:"所观人得安吉",
  77:"所观人不安吉",78:"所观人已无身",79:"所望见得睹之",80:"所求觅得见之",
  81:"求所闻得吉语",82:"所求见不如意",83:"观所疑即为实",84:"观所疑为不实",
  85:"所观人不和合",86:"求佛事当得获",87:"求供具当得获",88:"求资生得如意",
  89:"求资生少得获",90:"有所求皆当得",91:"有所求皆不得",92:"有所求少得获",
  93:"有所求得如意",94:"有所求速当得",95:"有所求久当得",96:"有所求而损失",
  97:"有所求得吉利",98:"有所求而受苦",99:"观所失求当得",100:"观所失求不得",
  101:"观所失自还得",102:"求离厄得脱难",103:"求离病得除愈",104:"观所去无障难",
  105:"观所去有障难",106:"观所住得安止",107:"观所住不得安",108:"所向处得安快",
  109:"所向处有厄难",110:"所向处为魔网",111:"所向处难开化",112:"所向处可开化",
  113:"所向处自获利",114:"所游路无恼害",115:"所游路有恼害",116:"君民恶饥馑起",
  117:"君民恶多疾疫",118:"君民好国丰乐",119:"君无道国灾乱",120:"君修德灾乱灭",
  121:"君行恶国将破",122:"君修善国还立",123:"观所避得度难",124:"观所避不脱难",
  125:"所住处众安隐",126:"所住处有障难",127:"所依聚众不安",128:"闲静处无诸难",
  129:"观怪异无损害",130:"观怪异有损害",131:"观怪异精进安",132:"观所梦无损害",
  133:"观所梦有损害",134:"观所梦精进安",135:"观所梦为吉利",136:"观障乱速得离",
  137:"观障乱渐得离",138:"观障乱不得离",139:"观障乱一心除",140:"观所难速得脱",
  141:"观所难久得脱",142:"观所难受衰恼",143:"观所难精进脱",144:"观所难命当尽",
  145:"观所患大不调",146:"观所患非人恼",147:"观所患合非人",148:"观所患可疗治",
  149:"观所患难疗治",150:"观所患精进差",151:"观所患久长苦",152:"观所患自当差",
  153:"所向医堪能治",154:"观所疗是对治",155:"所服药当得力",156:"观所患得除愈",
  157:"所向医不能治",158:"观所疗非对治",159:"所服药不得力",160:"观所患命当尽",
  161:"从地狱道中来",162:"从畜生道中来",163:"从饿鬼道中来",164:"从阿修罗道中来",
  165:"从人道中而来",166:"从天道中而来",167:"从在家中而来",168:"从出家中而来",
  169:"曾值佛供养来",170:"曾亲供养贤圣来",171:"曾得闻深法来",172:"舍身已入地狱",
  173:"舍身已作畜生",174:"舍身已作饿鬼",175:"舍身已作阿修罗",176:"舍身已生人道",
  177:"舍身已为人王",178:"舍身已生天道",179:"舍身已为天王",180:"舍身已闻深法",
  181:"舍身已得出家",182:"舍身已值圣僧",183:"舍身已生兜率天",184:"舍身已生净佛国",
  185:"舍身已寻见佛",186:"舍身已住下乘",187:"舍身已住中乘",188:"舍身已获果证",
  189:"舍身已住上乘"
};

/// 单个轮次记录
class RoundRecord {
  final int roundNumber;
  final int sum1;
  final int sum2;
  final int sum3;
  final int total;
  final String lunxiang;
  final String time;
  final List<List<int>> values;
  dynamic yanyan; // null=未设置, true=已应验, false=未应验, "pending"=待观察
  String beizhu;

  RoundRecord({
    required this.roundNumber,
    required this.sum1,
    required this.sum2,
    required this.sum3,
    required this.total,
    required this.lunxiang,
    required this.time,
    required this.values,
    this.yanyan,
    this.beizhu = '',
  });

  Map<String, dynamic> toJson() => {
    'roundNumber': roundNumber,
    'sum1': sum1,
    'sum2': sum2,
    'sum3': sum3,
    'total': total,
    'lunxiang': lunxiang,
    'time': time,
    'values': values,
    'yanyan': yanyan,
    'beizhu': beizhu,
  };

  factory RoundRecord.fromJson(Map<String, dynamic> json) => RoundRecord(
    roundNumber: json['roundNumber'] ?? 1,
    sum1: json['sum1'] ?? 0,
    sum2: json['sum2'] ?? 0,
    sum3: json['sum3'] ?? 0,
    total: json['total'] ?? 0,
    lunxiang: json['lunxiang'] ?? '',
    time: json['time'] ?? '',
    values: (json['values'] as List<dynamic>?)
        ?.map((e) => List<int>.from(e))
        ?.toList() ?? [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]],
    yanyan: json['yanyan'],
    beizhu: json['beizhu'] ?? '',
  );
}

/// 完整记录（一个设问可能有多轮）
class QuestionRecord {
  final String id;
  final String question;
  final String type;
  final List<RoundRecord> rounds;

  QuestionRecord({
    required this.id,
    required this.question,
    required this.type,
    required this.rounds,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'type': type,
    'rounds': rounds.map((r) => r.toJson()).toList(),
  };

  factory QuestionRecord.fromJson(Map<String, dynamic> json) => QuestionRecord(
    id: json['id'] ?? '',
    question: json['question'] ?? '',
    type: json['type'] ?? '',
    rounds: (json['rounds'] as List<dynamic>?)
        ?.map((e) => RoundRecord.fromJson(e))
        ?.toList() ?? [],
  );
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  final TextEditingController _sheWenController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  int _roundCount = 1; // 第几把
  bool _isSimple = false; // 简轨/全轨
  
  // 三组网格选择数据
  late List<List<int>> _val;
  
  // 3×6数字网格布局
  static const List<List<int>> _gridNumbers = [
    [1, 2, 3, 4, 5, 6],
    [7, 8, 9, 10, 11, 12],
    [13, 14, 15, 16, 17, 18],
  ];

  // 全屏历史页面控制
  bool _showHistory = false;
  List<QuestionRecord> _historyRecords = [];
  List<QuestionRecord> _filteredRecords = [];
  
  // 展开状态管理
  Set<String> _expandedIds = {};

  // 搜索相关状态
  String _searchKeyword = '';
  String _currentFilter = 'all'; // all, date, lunxiang
  DateTimeRange? _dateFilter;
  String? _lunxiangFilter;
  final TextEditingController _searchController = TextEditingController();
  
  // 排序状态：true=倒序（最新在前），false=正序（最旧在前）
  bool _isDescending = true;

  // 按钮点击变色状态
  String? _pressedButton; // 'new', 'track', 'next'
  Color _buttonDefaultColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _resetVal();
  }

  @override
  void dispose() {
    _sheWenController.dispose();
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _resetVal() {
    _val = [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
    ];
  }

  /// 根据数字确定分组索引
  static int getGroupIndex(int number) {
    return ((number - 1) / 3).floor();
  }

  /// 计算单组和值
  int _getSum(int gridIndex) {
    return _val[gridIndex].reduce((a, b) => a + b);
  }

  /// 第一组和
  int get _sum1 => _getSum(0);

  /// 第二组和
  int get _sum2 => _getSum(1);

  /// 第三组和
  int get _sum3 => _getSum(2);

  /// 总和
  int get _totalSum => _sum1 + _sum2 + _sum3;

  /// 获取轮相名称
  String get _lunxiangName {
    if (_totalSum >= 1 && _totalSum <= 189) {
      return wheelData[_totalSum] ?? '';
    }
    return '';
  }

  /// 显示标题
  String get _displayTitle {
    String text = '第$_roundCount把 $_sum1+$_sum2+$_sum3=$_totalSum';
    if (_lunxiangName.isNotEmpty) {
      text += '　$_lunxiangName';
    }
    return text;
  }

  /// 检查某个掷是否已完成
  bool _isGridCompleted(int gridIndex) {
    return _val[gridIndex].any((v) => v != 0);
  }

  /// 检查当前是否有任何选择
  bool _hasAnySelection() {
    return _val[0].any((v) => v != 0) || 
           _val[1].any((v) => v != 0) || 
           _val[2].any((v) => v != 0);
  }

  /// 格式化时间
  String _formatTime(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
           '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
  }

  /// 生成唯一ID
  String _generateId(String question, String type) {
    return '${question}_$type';
  }

  /// 点击数字格子
  void _onNumberTap(int gridIndex, int number) {
    final sheWen = _sheWenController.text.trim();
    if (sheWen.isEmpty) {
      _showTip("请先输入设问");
      return;
    }

    // 约束规则：已完成掷次不可更改
    if (gridIndex == 0 && _isGridCompleted(1)) {
      _showTip("第1掷结果不可更改");
      return;
    }
    if (gridIndex == 1 && _isGridCompleted(2)) {
      _showTip("第2掷结果不可更改");
      return;
    }

    final groupIndex = getGroupIndex(number);
    setState(() {
      _val[gridIndex][groupIndex] = _val[gridIndex][groupIndex] == number ? 0 : number;
    });

    // 实时保存
    _saveCurrentRound();
  }

  /// 判断数字是否被选中
  bool _isNumberSelected(int gridIndex, int number) {
    final groupIndex = getGroupIndex(number);
    return _val[gridIndex][groupIndex] == number;
  }

  /// 新设问
  void _newQuestion() {
    setState(() {
      _roundCount = 1;
      _resetVal();
      _sheWenController.clear();
    });
  }

  /// 下一把
  void _nextRound() {
    final sheWen = _sheWenController.text.trim();
    if (sheWen.isEmpty) {
      _showTip("请先输入设问");
      return;
    }

    if (!_hasAnySelection()) {
      _showTip("请先完成占察");
      return;
    }

    // 已经在实时保存中保存，这里只切换到下一把
    setState(() {
      _roundCount++;
      _resetVal();
    });
  }

  /// 实时保存当前轮次
  Future<void> _saveCurrentRound() async {
    final sheWen = _sheWenController.text.trim();
    if (sheWen.isEmpty) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = prefs.getString('chanRecords_v2');
      List<Map<String, dynamic>> records = [];
      
      if (recordsJson != null) {
        records = List<Map<String, dynamic>>.from(json.decode(recordsJson));
      }

      final typeStr = _isSimple ? "简轨" : "全轨";
      final id = _generateId(sheWen, typeStr);

      // 构建当前轮次数据
      final currentRound = RoundRecord(
        roundNumber: _roundCount,
        sum1: _sum1,
        sum2: _sum2,
        sum3: _sum3,
        total: _totalSum,
        lunxiang: _lunxiangName,
        time: _formatTime(DateTime.now()),
        values: _val.map((e) => List<int>.from(e)).toList(),
        yanyan: null,
        beizhu: '',
      );

      // 查找或创建该设问的记录
      int recordIndex = records.indexWhere((r) => r['id'] == id);
      
      if (recordIndex == -1) {
        // 新设问，添加到数组开头
        records.insert(0, {
          'id': id,
          'question': sheWen,
          'type': typeStr,
          'rounds': [currentRound.toJson()],
        });
      } else {
        // 已有设问，更新
        final record = records[recordIndex];
        final rounds = List<Map<String, dynamic>>.from(record['rounds'] ?? []);
        
        // 查找或添加当前轮次
        int roundIndex = rounds.indexWhere((r) => r['roundNumber'] == _roundCount);
        if (roundIndex >= 0) {
          // 更新时保留原有的yanyan和beizhu
          final existingRound = rounds[roundIndex];
          final updatedRound = currentRound.toJson();
          updatedRound['yanyan'] = existingRound['yanyan'];
          updatedRound['beizhu'] = existingRound['beizhu'] ?? '';
          rounds[roundIndex] = updatedRound;
        } else {
          rounds.add(currentRound.toJson()); // 添加
        }
        
        record['rounds'] = rounds;
        record['question'] = sheWen; // 更新设问内容
        
        // 将该记录移到最前面（最新）
        final updatedRecord = records.removeAt(recordIndex);
        records.insert(0, updatedRecord);
      }

      await prefs.setString('chanRecords_v2', json.encode(records));
    } catch (e) {
      debugPrint('保存记录失败: $e');
    }
  }

  /// 加载历史记录
  Future<List<QuestionRecord>> _loadRecords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = prefs.getString('chanRecords_v2');
      
      if (recordsJson == null) return [];
      
      final List<dynamic> recordsList = json.decode(recordsJson);
      return recordsList.map((json) => QuestionRecord.fromJson(json)).toList();
    } catch (e) {
      debugPrint('加载记录失败: $e');
      return [];
    }
  }

  /// 清空记录
  Future<void> _clearRecords() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认清空'),
        content: const Text('确定要清空所有占察记录吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('清空', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('chanRecords_v2');
      setState(() {
        _historyRecords = [];
      });
      _showTip('已清空记录');
    }
  }

  /// 显示历史记录全屏页面
  void _showHistoryPage() async {
    final records = await _loadRecords();
    setState(() {
      _historyRecords = records;
      _showHistory = true;
    });
  }

  /// 关闭历史记录页面
  void _closeHistoryPage() {
    setState(() {
      _showHistory = false;
    });
  }
  
  /// 切换展开/合并状态
  void _toggleExpand(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  /// 切换简轨/全轨
  void _toggleTrack() {
    setState(() {
      _isSimple = !_isSimple;
    });
  }

  /// 显示提示
  void _showTip(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.5,
          left: 50,
          right: 50,
        ),
      ),
    );
  }

  /// 构建数字按钮
  Widget _buildNumberButton(int gridIndex, int number) {
    final isSelected = _isNumberSelected(gridIndex, number);
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () => _onNumberTap(gridIndex, number),
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isSelected 
                  ? const Color(0xFF4682B4)
                  : const Color(0xFF87CEEB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 构建单行数字
  Widget _buildNumberRow(int gridIndex, List<int> numbers) {
    return Row(
      children: numbers.map((num) => _buildNumberButton(gridIndex, num)).toList(),
    );
  }

  /// 构建单组3×6数字网格
  Widget _buildSingleGrid(int gridIndex) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: _gridNumbers.map((row) => _buildNumberRow(gridIndex, row)).toList(),
      ),
    );
  }

  /// 主页面
  Widget _buildMainPage() {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部栏
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  // 历史按钮
                  GestureDetector(
                    onTap: _showHistoryPage,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text('📋', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                  // 标题
                  Expanded(
                    child: Text(
                      _displayTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // 占位
                  const SizedBox(width: 36),
                ],
              ),
            ),

            // 功能按钮行
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  // 新设问按钮
                  Expanded(
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _pressedButton = 'new'),
                      onTapUp: (_) {
                        Future.delayed(const Duration(milliseconds: 150), () {
                          if (mounted) setState(() => _pressedButton = null);
                        });
                        _newQuestion();
                      },
                      onTapCancel: () => setState(() => _pressedButton = null),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _pressedButton == 'new' ? Colors.grey.shade300 : _buttonDefaultColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '新设问',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 简轨/全轨按钮
                  Expanded(
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _pressedButton = 'track'),
                      onTapUp: (_) {
                        Future.delayed(const Duration(milliseconds: 150), () {
                          if (mounted) setState(() => _pressedButton = null);
                        });
                        _toggleTrack();
                      },
                      onTapCancel: () => setState(() => _pressedButton = null),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _pressedButton == 'track' ? Colors.grey.shade300 : _buttonDefaultColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _isSimple ? '全轨' : '简轨',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 下一把按钮
                  Expanded(
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _pressedButton = 'next'),
                      onTapUp: (_) {
                        Future.delayed(const Duration(milliseconds: 150), () {
                          if (mounted) setState(() => _pressedButton = null);
                        });
                        _nextRound();
                      },
                      onTapCancel: () => setState(() => _pressedButton = null),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _pressedButton == 'next' ? Colors.grey.shade300 : _buttonDefaultColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '下一把',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 设问输入框
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _sheWenController,
                focusNode: _focusNode,
                maxLines: null,
                minLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: '请输入设问',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
                style: const TextStyle(fontSize: 14, height: 1.4),
                onChanged: (_) => setState(() {}),
              ),
            ),

            const SizedBox(height: 12),

            // 三组数字网格
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(child: _buildSingleGrid(0)),
                    const SizedBox(height: 6),
                    Expanded(child: _buildSingleGrid(1)),
                    const SizedBox(height: 6),
                    Expanded(child: _buildSingleGrid(2)),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// 历史记录页面
  Widget _buildHistoryPage() {
    // 使用过滤后的记录或全部记录
    final displayRecords = _filteredRecords.isEmpty && _searchKeyword.isEmpty && _currentFilter == 'all'
        ? _historyRecords
        : _filteredRecords;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部栏
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEEEEEE)),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _closeHistoryPage,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text('← 返回', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      '占察记录',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // 导入按钮
                  GestureDetector(
                    onTap: _importRecords,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4682B4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '导入',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // 导出按钮
                  GestureDetector(
                    onTap: _showExportOptions,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4682B4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '导出',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: _clearRecords,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '清空',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 搜索栏
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEEEEEE)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '搜索设问、轮相号(1-189)...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        isDense: true,
                      ),
                      onChanged: _performSearch,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 排序按钮
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDescending = !_isDescending;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: _isDescending ? const Color(0xFFFF9800) : const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _isDescending ? '↓ 倒序' : '↑ 正序',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 日期筛选按钮
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: _currentFilter == 'date' ? const Color(0xFF4682B4) : const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '日期',
                        style: TextStyle(
                          fontSize: 14,
                          color: _currentFilter == 'date' ? Colors.white : const Color(0xFF666666),
                        ),
                      ),
                    ),
                  ),
                  if (_currentFilter != 'all')
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: GestureDetector(
                        onTap: _clearFilter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B6B),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '清除',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // 记录列表
            Expanded(
              child: displayRecords.isEmpty
                  ? Center(
                      child: Text(
                        _searchKeyword.isNotEmpty || _currentFilter != 'all' ? '未找到匹配记录' : '暂无记录',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: displayRecords.length,
                      itemBuilder: (context, index) {
                        final record = displayRecords[index];
                        // 根据排序状态决定轮次顺序
                        final allRounds = [...record.rounds]
                          ..sort((a, b) => _isDescending 
                            ? b.roundNumber.compareTo(a.roundNumber) 
                            : a.roundNumber.compareTo(b.roundNumber));
                        final lastRound = allRounds.isNotEmpty ? allRounds[0] : null;
                        final isExpanded = _expandedIds.contains(record.id);
                        
                        return GestureDetector(
                          onLongPress: () => _showCopyMenu(record),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                // 头部：设问 + 展开/合并按钮
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Color(0xFFEEEEEE)),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _highlightText(
                                              record.question,
                                              _searchKeyword,
                                              TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              record.type,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF4682B4),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _toggleExpand(record.id),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF0F0F0),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            isExpanded ? '合并' : '展开',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF666666),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // 默认显示最后一把
                                if (!isExpanded && lastRound != null)
                                  _buildRoundItem(lastRound, record.id),
                                
                                // 展开显示所有把次
                                if (isExpanded)
                                  ...allRounds.map((r) => _buildRoundItem(r, record.id)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// 格式化时间（显示月-日 时:分）
  String _formatTimeShort(String time) {
    if (time.length >= 16) {
      // 输入: "2026-04-25 06:40:00"
      // 输出: "04-25 06:40"
      final monthDay = time.substring(5, 10); // "04-25"
      final hourMin = time.substring(11, 16); // "06:40"
      return '$monthDay $hourMin';
    }
    return time;
  }

  /// 构建轮次记录项（两行布局）
  Widget _buildRoundItem(RoundRecord r, String recordId) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 第一行：第几把 + 计算结果 + 轮相 + 按钮
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      '第${r.roundNumber}把 ${r.sum1}+${r.sum2}+${r.sum3}=${r.total}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4682B4),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _highlightText(
                        r.lunxiang,
                        _searchKeyword,
                        const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 应验按钮
              _buildYanyanButton(r, recordId),
              const SizedBox(width: 6),
              // 备注按钮
              _buildBeizhuButton(r, recordId),
            ],
          ),
          const SizedBox(height: 2),
          // 第二行：时间 + 备注内容
          Row(
            children: [
              _highlightText(
                r.time,
                _searchKeyword,
                TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
              if (r.beizhu.isNotEmpty) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: _highlightText(
                    r.beizhu,
                    _searchKeyword,
                    TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// 构建应验按钮
  Widget _buildYanyanButton(RoundRecord r, String recordId) {
    Color bgColor;
    String text;
    Color textColor;

    if (r.yanyan == true) {
      bgColor = const Color(0xFF4CAF50);
      text = '已应验';
      textColor = Colors.white;
    } else if (r.yanyan == false) {
      bgColor = const Color(0xFFf44336);
      text = '未应验';
      textColor = Colors.white;
    } else if (r.yanyan?.toString() == 'pending') {
      bgColor = const Color(0xFFFF9800);
      text = '待观察';
      textColor = Colors.white;
    } else {
      bgColor = Colors.grey.shade200;
      text = '应验';
      textColor = Colors.black87;
    }

    return GestureDetector(
      onTap: () => _showYanyanDialog(recordId, r),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        ),
      ),
    );
  }

  /// 构建备注按钮
  Widget _buildBeizhuButton(RoundRecord r, String recordId) {
    final hasBeizhu = r.beizhu.isNotEmpty;
    return GestureDetector(
      onTap: () => _showBeizhuDialog(recordId, r),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: hasBeizhu ? const Color(0xFF2196F3) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          hasBeizhu ? '备注✓' : '备注',
          style: TextStyle(
            fontSize: 12,
            color: hasBeizhu ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  /// 搜索功能
  void _performSearch(String keyword) {
    final value = keyword.trim();
    
    // 判断是否为纯数字（轮相号搜索）
    if (RegExp(r'^\d+$').hasMatch(value)) {
      final lunxiangNum = int.tryParse(value);
      if (lunxiangNum != null && lunxiangNum >= 1 && lunxiangNum <= 189) {
        // 按轮相号搜索
        _searchByLunxiangNumber(lunxiangNum);
        return;
      } else {
        // 数字超出范围，显示提示
        _showTip('轮相号范围：1-189');
        setState(() {
          _filteredRecords = [];
          _searchKeyword = '';
          _currentFilter = 'all';
        });
        return;
      }
    }
    
    // 关键字搜索
    setState(() {
      _searchKeyword = value.toLowerCase();
      _currentFilter = 'all';
      _applyFilters();
    });
  }

  /// 按轮相号搜索
  void _searchByLunxiangNumber(int num) {
    final filtered = _historyRecords.where((record) {
      return record.rounds.any((r) => r.total == num);
    }).toList();
    
    setState(() {
      _filteredRecords = filtered;
      _searchKeyword = num.toString();
      _currentFilter = 'lunxiang';
    });
  }

  /// 清除筛选
  void _clearFilter() {
    setState(() {
      _currentFilter = 'all';
      _searchKeyword = '';
      _searchController.clear();
      _dateFilter = null;
      _lunxiangFilter = null;
      _filteredRecords = [];
    });
  }

  /// 应用所有筛选条件
  void _applyFilters() {
    List<QuestionRecord> filtered = List.from(_historyRecords);
    
    // 关键字搜索
    if (_searchKeyword.isNotEmpty) {
      filtered = filtered.where((record) {
        // 搜索设问
        if (record.question.toLowerCase().contains(_searchKeyword)) {
          return true;
        }
        // 搜索轮相
        if (record.rounds.any((r) => r.lunxiang.toLowerCase().contains(_searchKeyword))) {
          return true;
        }
        // 搜索时间
        if (record.rounds.any((r) => r.time.contains(_searchKeyword))) {
          return true;
        }
        // 搜索备注
        if (record.rounds.any((r) => r.beizhu.toLowerCase().contains(_searchKeyword))) {
          return true;
        }
        return false;
      }).toList();
    }
    
    // 日期筛选
    if (_currentFilter == 'date' && _dateFilter != null) {
      filtered = filtered.where((record) {
        return record.rounds.any((r) {
          final dateStr = r.time.split(' ')[0];
          final date = DateTime.tryParse(dateStr);
          if (date == null) return false;
          return date.isAfter(_dateFilter!.start.subtract(const Duration(days: 1))) &&
                 date.isBefore(_dateFilter!.end.add(const Duration(days: 1)));
        });
      }).toList();
    }
    
    _filteredRecords = filtered;
  }

  /// 显示日期选择器
  void _showDatePicker() async {
    final now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange: _dateFilter ?? DateTimeRange(
        start: DateTime(now.year, now.month, now.day),
        end: DateTime(now.year, now.month, now.day),
      ),
      helpText: '选择日期范围',
    );
    
    if (picked != null) {
      setState(() {
        _dateFilter = picked;
        _currentFilter = 'date';
        _lunxiangFilter = null;
        _searchKeyword = '';
        _searchController.clear();
        _applyFilters();
      });
    }
  }


  /// 高亮显示搜索关键字
  Widget _highlightText(String text, String keyword, TextStyle baseStyle) {
    if (keyword.isEmpty) {
      return Text(
        text,
        style: baseStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    
    final spans = <TextSpan>[];
    final lowerText = text.toLowerCase();
    final lowerKeyword = keyword.toLowerCase();
    int start = 0;
    int index;
    
    while ((index = lowerText.indexOf(lowerKeyword, start)) != -1) {
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index), style: baseStyle));
      }
      
      spans.add(TextSpan(
        text: text.substring(index, index + keyword.length),
        style: baseStyle.copyWith(
          backgroundColor: Colors.yellow.shade200,
        ),
      ));
      
      start = index + keyword.length;
    }
    
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: baseStyle));
    }
    
    return RichText(
      text: TextSpan(children: spans),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 显示应验状态选择对话框
  void _showYanyanDialog(String recordId, RoundRecord round) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('应验状态'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildYanyanOption(recordId, round, true, '已应验', const Color(0xFF4CAF50)),
            _buildYanyanOption(recordId, round, false, '未应验', const Color(0xFFf44336)),
            _buildYanyanOption(recordId, round, 'pending', '待观察', const Color(0xFFFF9800)),
            _buildYanyanOption(recordId, round, null, '清除', Colors.grey),
          ],
        ),
      ),
    );
  }

  /// 构建应验选项
  Widget _buildYanyanOption(String recordId, RoundRecord round, dynamic value, String text, Color color) {
    final isSelected = round.yanyan == value || (round.yanyan == null && value == null);
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      ),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.grey) : null,
      onTap: () {
        _updateYanyan(recordId, round.roundNumber, value);
        Navigator.pop(context);
      },
    );
  }

  /// 更新应验状态
  Future<void> _updateYanyan(String recordId, int roundNumber, dynamic value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = prefs.getString('chanRecords_v2');
      if (recordsJson == null) return;

      final List<dynamic> recordsList = json.decode(recordsJson);
      final recordIndex = recordsList.indexWhere((r) => r['id'] == recordId);
      if (recordIndex == -1) return;

      final record = recordsList[recordIndex];
      final rounds = List<Map<String, dynamic>>.from(record['rounds'] ?? []);
      final roundIndex = rounds.indexWhere((r) => r['roundNumber'] == roundNumber);
      if (roundIndex == -1) return;

      rounds[roundIndex]['yanyan'] = value;
      record['rounds'] = rounds;

      await prefs.setString('chanRecords_v2', json.encode(recordsList));

      // 刷新历史记录
      final records = await _loadRecords();
      setState(() {
        _historyRecords = records;
      });
    } catch (e) {
      debugPrint('更新应验状态失败: $e');
    }
  }

  /// 显示备注输入对话框
  void _showBeizhuDialog(String recordId, RoundRecord round) {
    final controller = TextEditingController(text: round.beizhu);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('备注'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: '请输入备注',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              _updateBeizhu(recordId, round.roundNumber, controller.text);
              Navigator.pop(context);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  /// 更新备注
  Future<void> _updateBeizhu(String recordId, int roundNumber, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = prefs.getString('chanRecords_v2');
      if (recordsJson == null) return;

      final List<dynamic> recordsList = json.decode(recordsJson);
      final recordIndex = recordsList.indexWhere((r) => r['id'] == recordId);
      if (recordIndex == -1) return;

      final record = recordsList[recordIndex];
      final rounds = List<Map<String, dynamic>>.from(record['rounds'] ?? []);
      final roundIndex = rounds.indexWhere((r) => r['roundNumber'] == roundNumber);
      if (roundIndex == -1) return;

      rounds[roundIndex]['beizhu'] = value;
      record['rounds'] = rounds;

      await prefs.setString('chanRecords_v2', json.encode(recordsList));

      // 刷新历史记录
      final records = await _loadRecords();
      setState(() {
        _historyRecords = records;
      });
    } catch (e) {
      debugPrint('更新备注失败: $e');
    }
  }

  /// 显示复制菜单
  void _showCopyMenu(QuestionRecord record) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('复制最后一把'),
              onTap: () {
                Navigator.pop(context);
                _copyLastRound(record);
              },
            ),
            ListTile(
              leading: const Icon(Icons.content_copy),
              title: const Text('复制全部记录'),
              onTap: () {
                Navigator.pop(context);
                _copyAllRounds(record);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('删除此记录', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(record);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.grey),
              title: const Text('取消', style: TextStyle(color: Colors.grey)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  /// 确认删除记录
  void _confirmDelete(QuestionRecord record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除此记录吗？\n设问：${record.question}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteRecord(record);
            },
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// 删除记录
  Future<void> _deleteRecord(QuestionRecord record) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = prefs.getString('chanRecords_v2');
      
      if (recordsJson != null) {
        final List<dynamic> recordsList = json.decode(recordsJson);
        
        // 移除指定记录
        recordsList.removeWhere((r) => r['id'] == record.id);
        
        await prefs.setString('chanRecords_v2', json.encode(recordsList));
        
        // 刷新历史记录
        final records = await _loadRecords();
        setState(() {
          _historyRecords = records;
        });
        
        _showTip('已删除记录');
      }
    } catch (e) {
      debugPrint('删除记录失败: $e');
    }
  }

  /// 复制最后一把
  void _copyLastRound(QuestionRecord record) async {
    if (record.rounds.isEmpty) {
      _showTip('暂无记录');
      return;
    }

    final sortedRounds = [...record.rounds]
      ..sort((a, b) => b.roundNumber.compareTo(a.roundNumber));
    final lastRound = sortedRounds.first;
    final text = _formatSingleRound(record, lastRound);

    await Clipboard.setData(ClipboardData(text: text));
    _showTip('已复制最后一把记录');
  }

  /// 复制全部记录
  void _copyAllRounds(QuestionRecord record) async {
    final text = _formatAllRounds(record);

    await Clipboard.setData(ClipboardData(text: text));
    _showTip('已复制全部记录');
  }

  /// 格式化单条轮次
  String _formatSingleRound(QuestionRecord record, RoundRecord round) {
    String text = '设问：${record.question}\n';
    text += '类型：${record.type}\n';
    text += '━━━━━━━━━━━━━━\n';
    text += '第${round.roundNumber}把 ${round.sum1}+${round.sum2}+${round.sum3}=${round.total} ${round.lunxiang}\n';
    text += '时间：${round.time}\n';
    if (round.yanyan != null) {
      text += '应验：${_getYanyanText(round.yanyan)}\n';
    }
    if (round.beizhu.isNotEmpty) {
      text += '备注：${round.beizhu}\n';
    }
    return text;
  }

  /// 格式化所有轮次
  String _formatAllRounds(QuestionRecord record) {
    String text = '设问：${record.question}\n';
    text += '类型：${record.type}\n';

    // 根据当前排序状态排序
    final sortedRounds = [...record.rounds]
      ..sort((a, b) => _isDescending 
        ? b.roundNumber.compareTo(a.roundNumber) 
        : a.roundNumber.compareTo(b.roundNumber));

    for (var round in sortedRounds) {
      text += '━━━━━━━━━━━━━━\n';
      text += '第${round.roundNumber}把 ${round.sum1}+${round.sum2}+${round.sum3}=${round.total} ${round.lunxiang}\n';
      text += '时间：${round.time}\n';
      if (round.yanyan != null) {
        text += '应验：${_getYanyanText(round.yanyan)}\n';
      }
      if (round.beizhu.isNotEmpty) {
        text += '备注：${round.beizhu}\n';
      }
    }

    text += '━━━━━━━━━━━━━━\n';
    return text;
  }

  /// 获取应验状态文本
  String _getYanyanText(dynamic yanyan) {
    if (yanyan == true) return '已应验';
    if (yanyan == false) return '未应验';
    if (yanyan.toString() == 'pending') return '待观察';
    return '';
  }

  // ========== 导入导出功能 ==========

  /// 显示导出格式选择
  void _showExportOptions() {
    if (_historyRecords.isEmpty) {
      _showTip('暂无记录可导出');
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('导出为TXT'),
              subtitle: const Text('纯文本格式，便于阅读'),
              onTap: () {
                Navigator.pop(context);
                _exportAsTxt();
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('导出为CSV'),
              subtitle: const Text('表格格式，可用Excel打开'),
              onTap: () {
                Navigator.pop(context);
                _exportAsCsv();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 导出为TXT格式
  Future<void> _exportAsTxt() async {
    final records = _historyRecords;
    
    String text = '';
    for (var record in records) {
      text += '═══════════════════════════════════\n';
      text += '设问：${record.question}\n';
      text += '类型：${record.type}\n';
      text += '═══════════════════════════════════\n';
      
      // 根据当前排序状态排序
      final sortedRounds = [...record.rounds]
        ..sort((a, b) => _isDescending 
          ? b.roundNumber.compareTo(a.roundNumber) 
          : a.roundNumber.compareTo(b.roundNumber));
      
      for (var round in sortedRounds) {
        text += '第${round.roundNumber}把 ${round.sum1}+${round.sum2}+${round.sum3}=${round.total} ${round.lunxiang}\n';
        text += '时间：${round.time}\n';
        if (round.yanyan != null) {
          text += '应验：${_getYanyanText(round.yanyan)}\n';
        }
        if (round.beizhu.isNotEmpty) {
          text += '备注：${round.beizhu}\n';
        }
        text += '────────────────────────────────────\n';
      }
      text += '\n';
    }
    
    // 让用户选择保存路径
    String? path = await FilePicker.platform.saveFile(
      dialogTitle: '选择保存位置',
      fileName: '占察记录_${DateTime.now().toString().substring(0, 10)}.txt',
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    
    if (path != null) {
      try {
        // 确保文件扩展名正确
        if (!path.endsWith('.txt')) {
          path = '$path.txt';
        }
        final file = File(path);
        await file.writeAsString(text, encoding: utf8);
        _showTip('导出成功');
      } catch (e) {
        debugPrint('导出失败: $e');
        _showTip('导出失败');
      }
    }
  }

  /// 导出为CSV格式
  Future<void> _exportAsCsv() async {
    final records = _historyRecords;
    
    String csv = '\uFEFF'; // BOM for UTF-8
    csv += '设问,类型,把数,第一组和,第二组和,第三组和,总和,轮相,时间,应验,备注\n';
    
    for (var record in records) {
      // 根据当前排序状态排序
      final sortedRounds = [...record.rounds]
        ..sort((a, b) => _isDescending 
          ? b.roundNumber.compareTo(a.roundNumber) 
          : a.roundNumber.compareTo(b.roundNumber));
      
      for (var round in sortedRounds) {
        csv += '"${_escapeCsv(record.question)}",';
        csv += '"${_escapeCsv(record.type)}",';
        csv += '${round.roundNumber},';
        csv += '${round.sum1},';
        csv += '${round.sum2},';
        csv += '${round.sum3},';
        csv += '${round.total},';
        csv += '"${_escapeCsv(round.lunxiang)}",';
        csv += '"${_escapeCsv(round.time)}",';
        csv += '"${_escapeCsv(_getYanyanText(round.yanyan))}",';
        csv += '"${_escapeCsv(round.beizhu)}"\n';
      }
    }
    
    // 让用户选择保存路径
    String? path = await FilePicker.platform.saveFile(
      dialogTitle: '选择保存位置',
      fileName: '占察记录_${DateTime.now().toString().substring(0, 10)}.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    
    if (path != null) {
      try {
        // 确保文件扩展名正确
        if (!path.endsWith('.csv')) {
          path = '$path.csv';
        }
        final file = File(path);
        await file.writeAsString(csv, encoding: utf8);
        _showTip('导出成功');
      } catch (e) {
        debugPrint('导出失败: $e');
        _showTip('导出失败');
      }
    }
  }

  /// CSV字段转义
  String _escapeCsv(String str) {
    if (str.isEmpty) return '';
    return str.replaceAll('"', '""');
  }

  /// 导入记录
  Future<void> _importRecords() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'csv'],
      );
      
      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final content = await file.readAsString(encoding: utf8);
        
        List<QuestionRecord> importedRecords;
        if (result.files.single.name.endsWith('.csv')) {
          importedRecords = _parseCsvFile(content);
        } else {
          importedRecords = _parseTxtFile(content);
        }
        
        await _mergeImportedRecords(importedRecords);
      }
    } catch (e) {
      debugPrint('导入失败: $e');
      _showTip('导入失败');
    }
  }

  /// 解析TXT格式文件
  List<QuestionRecord> _parseTxtFile(String content) {
    final records = <QuestionRecord>[];
    final sections = content.split(RegExp(r'═══════════════════════════════════'));
    
    for (var section in sections) {
      if (section.trim().isEmpty) continue;
      
      final lines = section.trim().split('\n');
      String question = '';
      String type = '全轨';
      final rounds = <RoundRecord>[];
      
      RoundRecord? currentRound;
      
      for (var line in lines) {
        if (line.startsWith('设问：')) {
          question = line.substring(3).trim();
        } else if (line.startsWith('类型：')) {
          type = line.substring(3).trim();
        } else if (RegExp(r'^第\d+把').hasMatch(line)) {
          if (currentRound != null) {
            rounds.add(currentRound);
          }
          
          final match = RegExp(r'第(\d+)把\s+(\d+)\+(\d+)\+(\d+)=(\d+)\s+(.+)').firstMatch(line);
          if (match != null) {
            currentRound = RoundRecord(
              roundNumber: int.parse(match.group(1)!),
              sum1: int.parse(match.group(2)!),
              sum2: int.parse(match.group(3)!),
              sum3: int.parse(match.group(4)!),
              total: int.parse(match.group(5)!),
              lunxiang: match.group(6)!.trim(),
              time: '',
              values: [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]],
              yanyan: null,
              beizhu: '',
            );
          }
        } else if (line.startsWith('时间：') && currentRound != null) {
          currentRound = RoundRecord(
            roundNumber: currentRound.roundNumber,
            sum1: currentRound.sum1,
            sum2: currentRound.sum2,
            sum3: currentRound.sum3,
            total: currentRound.total,
            lunxiang: currentRound.lunxiang,
            time: line.substring(3).trim(),
            values: currentRound.values,
            yanyan: currentRound.yanyan,
            beizhu: currentRound.beizhu,
          );
        } else if (line.startsWith('应验：') && currentRound != null) {
          currentRound = RoundRecord(
            roundNumber: currentRound.roundNumber,
            sum1: currentRound.sum1,
            sum2: currentRound.sum2,
            sum3: currentRound.sum3,
            total: currentRound.total,
            lunxiang: currentRound.lunxiang,
            time: currentRound.time,
            values: currentRound.values,
            yanyan: _parseYanyanText(line.substring(3).trim()),
            beizhu: currentRound.beizhu,
          );
        } else if (line.startsWith('备注：') && currentRound != null) {
          currentRound = RoundRecord(
            roundNumber: currentRound.roundNumber,
            sum1: currentRound.sum1,
            sum2: currentRound.sum2,
            sum3: currentRound.sum3,
            total: currentRound.total,
            lunxiang: currentRound.lunxiang,
            time: currentRound.time,
            values: currentRound.values,
            yanyan: currentRound.yanyan,
            beizhu: line.substring(3).trim(),
          );
        }
      }
      
      if (currentRound != null) {
        rounds.add(currentRound);
      }
      
      if (question.isNotEmpty) {
        records.add(QuestionRecord(
          id: _generateId(question, type),
          question: question,
          type: type,
          rounds: rounds,
        ));
      }
    }
    
    return records;
  }

  /// 解析CSV格式文件
  List<QuestionRecord> _parseCsvFile(String content) {
    final records = <QuestionRecord>[];
    final lines = content.split('\n');
    
    // 跳过表头
    for (int i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;
      
      final values = _parseCsvLine(line);
      if (values.length < 8) continue;
      
      final question = values[0];
      final type = values[1];
      if (question.isEmpty) continue;
      
      // 查找或创建记录
      String recordId = _generateId(question, type);
      QuestionRecord? record = records.cast<QuestionRecord?>().firstWhere(
        (r) => r?.id == recordId,
        orElse: () => null,
      );
      
      if (record == null) {
        record = QuestionRecord(
          id: recordId,
          question: question,
          type: type.isEmpty ? '全轨' : type,
          rounds: [],
        );
        records.add(record);
      }
      
      // 添加轮次
      record.rounds.add(RoundRecord(
        roundNumber: int.tryParse(values[2]) ?? 1,
        sum1: int.tryParse(values[3]) ?? 0,
        sum2: int.tryParse(values[4]) ?? 0,
        sum3: int.tryParse(values[5]) ?? 0,
        total: int.tryParse(values[6]) ?? 0,
        lunxiang: values[7],
        time: values.length > 8 ? values[8] : '',
        values: [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]],
        yanyan: _parseYanyanText(values.length > 9 ? values[9] : ''),
        beizhu: values.length > 10 ? values[10] : '',
      ));
    }
    
    return records;
  }

  /// 解析CSV行
  List<String> _parseCsvLine(String line) {
    final values = <String>[];
    String current = '';
    bool inQuotes = false;
    
    for (int i = 0; i < line.length; i++) {
      final char = line[i];
      
      if (char == '"') {
        if (inQuotes && i + 1 < line.length && line[i + 1] == '"') {
          current += '"';
          i++;
        } else {
          inQuotes = !inQuotes;
        }
      } else if (char == ',' && !inQuotes) {
        values.add(current.trim());
        current = '';
      } else {
        current += char;
      }
    }
    
    values.add(current.trim());
    return values;
  }

  /// 解析应验状态文本
  dynamic _parseYanyanText(String text) {
    if (text.isEmpty) return null;
    if (text == '已应验') return true;
    if (text == '未应验') return false;
    if (text == '待观察') return 'pending';
    return null;
  }

  /// 合并导入的记录
  Future<void> _mergeImportedRecords(List<QuestionRecord> importedRecords) async {
    if (importedRecords.isEmpty) {
      _showTip('未找到有效记录');
      return;
    }
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final recordsJson = prefs.getString('chanRecords_v2');
      List<Map<String, dynamic>> existingRecords = [];
      
      if (recordsJson != null) {
        existingRecords = List<Map<String, dynamic>>.from(json.decode(recordsJson));
      }
      
      int addedCount = 0;
      int mergedCount = 0;
      
      for (var imported in importedRecords) {
        final existingIndex = existingRecords.indexWhere((r) => r['id'] == imported.id);
        
        if (existingIndex >= 0) {
          // 合并轮次
          final existing = existingRecords[existingIndex];
          final existingRounds = List<Map<String, dynamic>>.from(existing['rounds'] ?? []);
          
          for (var round in imported.rounds) {
            final existingRoundIndex = existingRounds.indexWhere(
              (r) => r['roundNumber'] == round.roundNumber,
            );
            if (existingRoundIndex < 0) {
              existingRounds.add(round.toJson());
              mergedCount++;
            }
          }
          
          existing['rounds'] = existingRounds;
        } else {
          existingRecords.add(imported.toJson());
          addedCount++;
        }
      }
      
      await prefs.setString('chanRecords_v2', json.encode(existingRecords));
      
      // 刷新历史记录
      final records = await _loadRecords();
      setState(() {
        _historyRecords = records;
      });
      
      _showTip('导入成功：新增$addedCount条，合并$mergedCount条');
    } catch (e) {
      debugPrint('合并记录失败: $e');
      _showTip('导入失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showHistory ? _buildHistoryPage() : _buildMainPage();
  }
}
