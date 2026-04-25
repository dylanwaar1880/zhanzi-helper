/// 占察记录数据模型
/// 用于存储用户的占察历史记录

class ZhanziRecord {
  final int? id;
  final String sheWen;
  final int number1;
  final int number2;
  final int number3;
  final int sum;
  final int lunxiangId;
  final bool isFavorite;
  final DateTime createdAt;

  const ZhanziRecord({
    this.id,
    required this.sheWen,
    required this.number1,
    required this.number2,
    required this.number3,
    required this.sum,
    required this.lunxiangId,
    this.isFavorite = false,
    required this.createdAt,
  });

  /// 创建空记录
  factory ZhanziRecord.empty() => ZhanziRecord(
        sheWen: '',
        number1: 0,
        number2: 0,
        number3: 0,
        sum: 0,
        lunxiangId: 0,
        createdAt: DateTime.now(),
      );

  /// 从JSON创建
  factory ZhanziRecord.fromJson(Map<String, dynamic> json) => ZhanziRecord(
        id: json['id'] as int?,
        sheWen: json['she_wen'] as String? ?? '',
        number1: json['number1'] as int? ?? 0,
        number2: json['number2'] as int? ?? 0,
        number3: json['number3'] as int? ?? 0,
        sum: json['sum'] as int? ?? 0,
        lunxiangId: json['lunxiang_id'] as int? ?? 0,
        isFavorite: (json['is_favorite'] as int? ?? 0) == 1,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : DateTime.now(),
      );

  /// 转换为JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'she_wen': sheWen,
        'number1': number1,
        'number2': number2,
        'number3': number3,
        'sum': sum,
        'lunxiang_id': lunxiangId,
        'is_favorite': isFavorite ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
      };

  /// 复制并修改
  ZhanziRecord copyWith({
    int? id,
    String? sheWen,
    int? number1,
    int? number2,
    int? number3,
    int? sum,
    int? lunxiangId,
    bool? isFavorite,
    DateTime? createdAt,
  }) =>
      ZhanziRecord(
        id: id ?? this.id,
        sheWen: sheWen ?? this.sheWen,
        number1: number1 ?? this.number1,
        number2: number2 ?? this.number2,
        number3: number3 ?? this.number3,
        sum: sum ?? this.sum,
        lunxiangId: lunxiangId ?? this.lunxiangId,
        isFavorite: isFavorite ?? this.isFavorite,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  String toString() =>
      'ZhanziRecord(id: $id, sheWen: $sheWen, numbers: [$number1, $number2, $number3], sum: $sum, lunxiangId: $lunxiangId, isFavorite: $isFavorite)';
}

/// 占察结果状态枚举
enum ZhanziState {
  idle, // 空闲状态
  rolling, // 掷轮中
  completed, // 完成
}
