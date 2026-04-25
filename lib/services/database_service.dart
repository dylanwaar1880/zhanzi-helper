import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils/constants.dart';
import '../../data_models/zhanzi_record.dart';
import '../../data_models/she_wen.dart';

/// SQLite数据库服务
class DatabaseService {
  static Database? _database;
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  /// 获取数据库实例
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// 初始化数据库
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.dbName);

    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// 创建表
  Future<void> _onCreate(Database db, int version) async {
    // 创建占察记录表
    await db.execute('''
      CREATE TABLE ${AppConstants.tableRecords} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        she_wen TEXT NOT NULL,
        number1 INTEGER NOT NULL,
        number2 INTEGER NOT NULL,
        number3 INTEGER NOT NULL,
        sum INTEGER NOT NULL,
        lunxiang_id INTEGER NOT NULL,
        is_favorite INTEGER DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');

    // 创建设问模板表
    await db.execute('''
      CREATE TABLE ${AppConstants.tableSheWen} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        use_count INTEGER DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');

    // 创建索引
    await db.execute('''
      CREATE INDEX idx_records_created_at ON ${AppConstants.tableRecords}(created_at)
    ''');
    await db.execute('''
      CREATE INDEX idx_records_is_favorite ON ${AppConstants.tableRecords}(is_favorite)
    ''');
  }

  /// 升级数据库
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 预留升级逻辑
  }

  // ==================== 占察记录操作 ====================

  /// 添加占察记录
  Future<int> insertRecord(ZhanziRecord record) async {
    final db = await database;
    return await db.insert(AppConstants.tableRecords, record.toJson());
  }

  /// 获取所有占察记录
  Future<List<ZhanziRecord>> getAllRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.tableRecords,
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => ZhanziRecord.fromJson(map)).toList();
  }

  /// 获取收藏的记录
  Future<List<ZhanziRecord>> getFavoriteRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.tableRecords,
      where: 'is_favorite = ?',
      whereArgs: [1],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => ZhanziRecord.fromJson(map)).toList();
  }

  /// 按ID获取记录
  Future<ZhanziRecord?> getRecordById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.tableRecords,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return ZhanziRecord.fromJson(maps.first);
  }

  /// 更新记录收藏状态
  Future<int> updateRecordFavorite(int id, bool isFavorite) async {
    final db = await database;
    return await db.update(
      AppConstants.tableRecords,
      {'is_favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 删除记录
  Future<int> deleteRecord(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableRecords,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 清空所有记录
  Future<int> clearAllRecords() async {
    final db = await database;
    return await db.delete(AppConstants.tableRecords);
  }

  /// 获取记录数量
  Future<int> getRecordCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${AppConstants.tableRecords}',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// 获取轮相分布统计
  Future<Map<int, int>> getLunxiangDistribution() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT lunxiang_id, COUNT(*) as count 
      FROM ${AppConstants.tableRecords} 
      GROUP BY lunxiang_id
    ''');
    return Map.fromEntries(
      maps.map((m) => MapEntry(m['lunxiang_id'] as int, m['count'] as int)),
    );
  }

  // ==================== 设问模板操作 ====================

  /// 添加设问模板
  Future<int> insertSheWen(SheWen sheWen) async {
    final db = await database;
    return await db.insert(AppConstants.tableSheWen, sheWen.toJson());
  }

  /// 获取所有设问模板
  Future<List<SheWen>> getAllSheWen() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.tableSheWen,
      orderBy: 'use_count DESC, created_at DESC',
    );
    return maps.map((map) => SheWen.fromJson(map)).toList();
  }

  /// 更新设问模板使用次数
  Future<int> updateSheWenUseCount(int id) async {
    final db = await database;
    return await db.rawUpdate('''
      UPDATE ${AppConstants.tableSheWen} 
      SET use_count = use_count + 1 
      WHERE id = ?
    ''', [id]);
  }

  /// 删除设问模板
  Future<int> deleteSheWen(int id) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableSheWen,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// 关闭数据库
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
