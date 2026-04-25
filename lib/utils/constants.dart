/// 占察助手常量定义

class AppConstants {
  // 应用信息
  static const String appName = '占察助手';
  static const String appVersion = '1.0.0';

  // 轮相相关
  static const int lunxiangCount = 189;
  static const int numberMin = 1;
  static const int numberMax = 18;
  static const int sumMin = 3; // 1+1+1
  static const int sumMax = 54; // 18+18+18

  // 动画时长（毫秒）
  static const int rollAnimationDuration = 2000;
  static const int numberChangeInterval = 50;
  static const int numberChangeSlowdownFactor = 3;

  // 数据库
  static const String dbName = 'zhanzi_helper.db';
  static const int dbVersion = 1;
  static const String tableRecords = 'zhanzi_records';
  static const String tableSheWen = 'she_wen_templates';

  // SharedPreferences keys
  static const String keyThemeMode = 'theme_mode';
  static const String keySimpleMode = 'simple_mode';
  static const String keyFirstLaunch = 'first_launch';
  static const String keyStatistics = 'statistics';

  // 主题模式
  static const String themeModeLight = 'light';
  static const String themeModeDark = 'dark';
  static const String themeModeSystem = 'system';

  // 筛选类型
  static const String filterAll = 'all';
  static const String filterFavorite = 'favorite';
  static const String filterAuspicious = 'auspicious';
  static const String filterInauspicious = 'inauspicious';
}

/// 轮相分类
class LunxiangCategories {
  static const String 观善恶业 = '观善恶业';
  static const String 观所疑 = '观所疑';
  static const String 观所梦 = '观所梦';
  static const String 观所闻 = '观所闻';
  static const String 观所求 = '观所求';
  static const String 观所失 = '观所失';
  static const String 观所忧 = '观所忧';
  static const String 观所恶 = '观所恶';
  static const String 观所取 = '观所取';
  static const String 观业果报 = '观业果报';

  static const List<String> all = [
    观善恶业,
    观所疑,
    观所梦,
    观所闻,
    观所求,
    观所失,
    观所忧,
    观所恶,
    观所取,
    观业果报,
  ];
}
