import 'package:flutter/foundation.dart';
import 'dart:math';
import '../../data_models/zhanzi_record.dart';
import '../../data_models/lunxiang_data.dart';
import '../../data_models/she_wen.dart';
import '../services/database_service.dart';
import '../services/storage_service.dart';

/// 占察状态管理
class ZhanziProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  final StorageService _storage = StorageService();

  // 当前状态
  ZhanziState _state = ZhanziState.idle;
  String _sheWen = '';
  int _number1 = 0;
  int _number2 = 0;
  int _number3 = 0;
  int _sum = 0;
  int _lunxiangId = 0;
  Lunxiang? _currentLunxiang;

  // 动画相关
  int _displayNumber1 = 0;
  int _displayNumber2 = 0;
  int _displayNumber3 = 0;

  // 历史记录
  List<ZhanziRecord> _records = [];
  List<SheWen> _sheWenTemplates = [];

  // 筛选
  String _filterType = 'all';

  // Getter
  ZhanziState get state => _state;
  String get sheWen => _sheWen;
  int get number1 => _number1;
  int get number2 => _number2;
  int get number3 => _number3;
  int get sum => _sum;
  int get lunxiangId => _lunxiangId;
  Lunxiang? get currentLunxiang => _currentLunxiang;
  int get displayNumber1 => _displayNumber1;
  int get displayNumber2 => _displayNumber2;
  int get displayNumber3 => _displayNumber3;
  List<ZhanziRecord> get records => _records;
  List<SheWen> get sheWenTemplates => _sheWenTemplates;
  String get filterType => _filterType;

  bool get isRolling => _state == ZhanziState.rolling;
  bool get hasResult => _state == ZhanziState.completed && _lunxiangId > 0;

  /// 初始化
  Future<void> init() async {
    await loadRecords();
    await loadSheWenTemplates();
  }

  /// 设置设问
  void setSheWen(String text) {
    _sheWen = text;
    notifyListeners();
  }

  /// 开始掷轮
  Future<void> startRolling() async {
    if (_state == ZhanziState.rolling) return;

    _state = ZhanziState.rolling;
    _number1 = 0;
    _number2 = 0;
    _number3 = 0;
    _sum = 0;
    _lunxiangId = 0;
    _currentLunxiang = null;
    notifyListeners();

    // 生成最终结果
    final random = Random();
    _number1 = random.nextInt(18) + 1;
    _number2 = random.nextInt(18) + 1;
    _number3 = random.nextInt(18) + 1;
    _sum = _number1 + _number2 + _number3;

    // 根据和值获取轮相ID
    _lunxiangId = _getLunxiangIdBySum(_sum);
    _currentLunxiang = getLunxiangById(_lunxiangId);

    // 动画模拟将在UI层处理
    // 这里只是更新最终值
    notifyListeners();
  }

  /// 根据和值获取轮相ID
  int _getLunxiangIdBySum(int sum) {
    // 和值3-54对应轮相1-189
    // 建立映射关系
    if (sum < 3 || sum > 54) return 1;

    // 简化的映射算法
    // 将和值3-54映射到1-189
    // 使用更合理的分布
    if (sum <= 11) {
      // 3-11 -> 1-10 (第一组)
      return sum - 2;
    } else if (sum <= 21) {
      // 12-21 -> 11-40 (第二组)
      return 10 + (sum - 11) * 3;
    } else if (sum <= 31) {
      // 22-31 -> 41-90 (第三组)
      return 40 + (sum - 21) * 5;
    } else if (sum <= 41) {
      // 32-41 -> 91-140 (第四组)
      return 90 + (sum - 31) * 5;
    } else if (sum <= 51) {
      // 42-51 -> 141-180 (第五组)
      return 140 + (sum - 41) * 4;
    } else {
      // 52-54 -> 181-189 (第六组)
      return 180 + (sum - 51);
    }
  }

  /// 完成掷轮动画
  Future<void> completeRolling() async {
    _state = ZhanziState.completed;

    // 保存记录
    if (_sheWen.isNotEmpty) {
      final record = ZhanziRecord(
        sheWen: _sheWen,
        number1: _number1,
        number2: _number2,
        number3: _number3,
        sum: _sum,
        lunxiangId: _lunxiangId,
        createdAt: DateTime.now(),
      );
      await _db.insertRecord(record);
      await _storage.addRecentSheWen(_sheWen);
      await loadRecords();
    }

    notifyListeners();
  }

  /// 重置状态
  void reset() {
    _state = ZhanziState.idle;
    _sheWen = '';
    _number1 = 0;
    _number2 = 0;
    _number3 = 0;
    _sum = 0;
    _lunxiangId = 0;
    _currentLunxiang = null;
    _displayNumber1 = 0;
    _displayNumber2 = 0;
    _displayNumber3 = 0;
    notifyListeners();
  }

  /// 设置分组结果
  void setGroupResults(int round1Sum, int round2Sum, int round3Sum, int totalSum) {
    _state = ZhanziState.completed;
    _number1 = round1Sum;
    _number2 = round2Sum;
    _number3 = round3Sum;
    _sum = totalSum;
    
    // 根据总和获取轮相ID
    _lunxiangId = _getLunxiangIdBySum(_sum);
    _currentLunxiang = getLunxiangById(_lunxiangId);
    notifyListeners();
  }

  /// 新设问
  void newQuestion() {
    reset();
  }

  /// 下一把（复用当前设问）
  void nextRound() {
    _state = ZhanziState.idle;
    _number1 = 0;
    _number2 = 0;
    _number3 = 0;
    _sum = 0;
    _lunxiangId = 0;
    _currentLunxiang = null;
    notifyListeners();
  }

  /// 加载历史记录
  Future<void> loadRecords() async {
    _records = await _db.getAllRecords();
    notifyListeners();
  }

  /// 加载设问模板
  Future<void> loadSheWenTemplates() async {
    _sheWenTemplates = await _db.getAllSheWen();
    notifyListeners();
  }

  /// 设置筛选类型
  void setFilter(String type) {
    _filterType = type;
    notifyListeners();
  }

  /// 获取筛选后的记录
  List<ZhanziRecord> getFilteredRecords() {
    switch (_filterType) {
      case 'favorite':
        return _records.where((r) => r.isFavorite).toList();
      case 'auspicious':
        return _records
            .where((r) =>
                getLunxiangById(r.lunxiangId)?.isAuspicious ?? false)
            .toList();
      case 'inauspicious':
        return _records
            .where((r) =>
                !(getLunxiangById(r.lunxiangId)?.isAuspicious ?? true))
            .toList();
      default:
        return _records;
    }
  }

  /// 切换收藏状态
  Future<void> toggleFavorite(int recordId) async {
    final record = _records.firstWhere(
      (r) => r.id == recordId,
      orElse: () => throw Exception('Record not found'),
    );
    await _db.updateRecordFavorite(recordId, !record.isFavorite);
    await loadRecords();
  }

  /// 删除记录
  Future<void> deleteRecord(int recordId) async {
    await _db.deleteRecord(recordId);
    await loadRecords();
  }

  /// 添加设问模板
  Future<void> addSheWenTemplate(String content) async {
    if (content.trim().isEmpty) return;
    final sheWen = SheWen.create(content);
    await _db.insertSheWen(sheWen);
    await loadSheWenTemplates();
  }

  /// 删除设问模板
  Future<void> deleteSheWenTemplate(int id) async {
    await _db.deleteSheWen(id);
    await loadSheWenTemplates();
  }

  /// 使用设问模板
  Future<void> useSheWenTemplate(int id) async {
    await _db.updateSheWenUseCount(id);
    await loadSheWenTemplates();
  }

  /// 获取统计数据
  Future<Map<String, int>> getStatistics() async {
    final distribution = await _db.getLunxiangDistribution();
    return {
      'totalCount': _records.length,
      'favoriteCount': _records.where((r) => r.isFavorite).length,
      ...distribution,
    };
  }
}
