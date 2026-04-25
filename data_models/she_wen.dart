/// 设问模板数据模型
/// 用于存储用户常用的占察设问模板

class SheWen {
  final int? id;
  final String content;
  final int useCount;
  final DateTime createdAt;

  const SheWen({
    this.id,
    required this.content,
    this.useCount = 0,
    required this.createdAt,
  });

  /// 创建新模板
  factory SheWen.create(String content) => SheWen(
        content: content,
        createdAt: DateTime.now(),
      );

  /// 从JSON创建
  factory SheWen.fromJson(Map<String, dynamic> json) => SheWen(
        id: json['id'] as int?,
        content: json['content'] as String? ?? '',
        useCount: json['use_count'] as int? ?? 0,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : DateTime.now(),
      );

  /// 转换为JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'use_count': useCount,
        'created_at': createdAt.toIso8601String(),
      };

  /// 复制并修改
  SheWen copyWith({
    int? id,
    String? content,
    int? useCount,
    DateTime? createdAt,
  }) =>
      SheWen(
        id: id ?? this.id,
        content: content ?? this.content,
        useCount: useCount ?? this.useCount,
        createdAt: createdAt ?? this.createdAt,
      );

  /// 使用次数+1
  SheWen incrementUseCount() => copyWith(useCount: useCount + 1);

  @override
  String toString() =>
      'SheWen(id: $id, content: $content, useCount: $useCount)';
}

/// 预设的常用设问模板
class PresetSheWen {
  static const List<String> templates = [
    '请观我近日运势如何？',
    '请观我所求之事能否成就？',
    '请观我与此人的因缘如何？',
    '请观我近日健康状况如何？',
    '请观我近日财运如何？',
    '请观我所担心之事是否属实？',
    '请观我近日小人运势如何？',
    '请观我贵人运势如何？',
    '请观我近日有无灾祸？',
    '请观我事业前途如何？',
    '请观我学业进展如何？',
    '请观我家庭和睦否？',
    '请观我与他人的关系如何？',
    '请观我出行平安否？',
    '请观我近日做梦之吉凶？',
    '请观我心中的疑惑是否属实？',
    '请观我所失之物能否找回？',
    '请观我忧患之事能否化解？',
    '请观我厌恶之人当如何对待？',
    '请观我住处是否安稳？',
    '请观我宿世业障如何？',
    '请观我现世果报如何？',
    '请观我应当修何法门？',
    '请观我应当亲近何人？',
    '请观我应当远离何人？',
    '请观我是否应当改变现状？',
    '请观我此事应当如何处理？',
    '请观我应当等待还是行动？',
    '请观我此事成败如何？',
    '请观我如何才能如愿？',
  ];

  /// 获取所有预设模板
  static List<SheWen> getAll() {
    return templates
        .map((content) => SheWen(content: content, createdAt: DateTime.now()))
        .toList();
  }
}
