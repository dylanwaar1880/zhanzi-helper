import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

/// SharedPreferences存储服务
class StorageService {
  static SharedPreferences? _prefs;
  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;

  StorageService._internal();

  /// 初始化
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 获取prefs实例
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('StorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // ==================== 主题设置 ====================

  /// 获取主题模式
  String getThemeMode() {
    return prefs.getString(AppConstants.keyThemeMode) ??
        AppConstants.themeModeSystem;
  }

  /// 设置主题模式
  Future<bool> setThemeMode(String mode) {
    return prefs.setString(AppConstants.keyThemeMode, mode);
  }

  // ==================== 简轨/繁轨设置 ====================

  /// 获取是否简轨模式
  bool getSimpleMode() {
    return prefs.getBool(AppConstants.keySimpleMode) ?? false;
  }

  /// 设置简轨/繁轨模式
  Future<bool> setSimpleMode(bool simple) {
    return prefs.setBool(AppConstants.keySimpleMode, simple);
  }

  // ==================== 首次启动 ====================

  /// 是否首次启动
  bool isFirstLaunch() {
    return prefs.getBool(AppConstants.keyFirstLaunch) ?? true;
  }

  /// 设置首次启动标记
  Future<bool> setFirstLaunch(bool first) {
    return prefs.setBool(AppConstants.keyFirstLaunch, first);
  }

  // ==================== 统计数据 ====================

  /// 获取统计数据
  Map<String, dynamic> getStatistics() {
    final json = prefs.getString(AppConstants.keyStatistics);
    if (json == null) {
      return {
        'totalCount': 0,
        'todayCount': 0,
        'weekCount': 0,
        'monthCount': 0,
      };
    }
    // 简单解析，如果解析失败返回默认
    try {
      // 这里简化处理，实际应该用json解析
      return {
        'totalCount': 0,
        'todayCount': 0,
        'weekCount': 0,
        'monthCount': 0,
      };
    } catch (e) {
      return {
        'totalCount': 0,
        'todayCount': 0,
        'weekCount': 0,
        'monthCount': 0,
      };
    }
  }

  /// 更新统计数据
  Future<bool> updateStatistics(Map<String, dynamic> stats) {
    // 简化实现
    return Future.value(true);
  }

  /// 增加今日计数
  Future<void> incrementTodayCount() async {
    // 实现计数逻辑
  }

  // ==================== 历史设问 ====================

  /// 获取历史设问列表
  List<String> getRecentSheWen() {
    return prefs.getStringList('recent_she_wen') ?? [];
  }

  /// 添加历史设问
  Future<void> addRecentSheWen(String sheWen) async {
    if (sheWen.trim().isEmpty) return;
    final list = getRecentSheWen();
    // 移除已有的相同内容
    list.remove(sheWen);
    // 添加到最前面
    list.insert(0, sheWen);
    // 最多保存20条
    if (list.length > 20) {
      list.removeLast();
    }
    await prefs.setStringList('recent_she_wen', list);
  }

  /// 清除历史设问
  Future<void> clearRecentSheWen() async {
    await prefs.remove('recent_she_wen');
  }

  // ==================== 数据导出/导入 ====================

  /// 导出所有数据为JSON字符串
  Future<String> exportData() async {
    // 实现数据导出
    return '{}';
  }

  /// 导入数据
  Future<bool> importData(String jsonData) async {
    // 实现数据导入
    return false;
  }

  /// 清除所有数据
  Future<bool> clearAll() async {
    return await prefs.clear();
  }
}
