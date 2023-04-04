class Todo {
  /// 管理ID
  final int? id;

  /// タスク名
  final String name;

  /// スパン　○日に1回
  final int span;

  /// リマインド
  final bool remind;

  /// タスクに要する時間
  final int? time;

  /// これまでの実施回数
  final int count;

  /// タスクのスキップ回数
  final int skipCount;

  /// タスクの連続スキップ回数
  final int skipConsecutive;

  /// カテゴリID
  final int? categoryId;

  /// 実施日
  final List<DateTime> completeDate;

  /// 一つ前の実施予定日
  final DateTime? preExpectedDate;

  /// 実施予定日
  final DateTime? expectedDate;

  /// 作成日時
  final DateTime? createdAt;

  /// 更新日時
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Todo{id: $id, name: $name, span: $span, remind: $remind, time: $time, count: $count, skipCount: $skipCount, skipConsecutive: $skipConsecutive, categoryId: $categoryId, completeDate: $completeDate, preExpectedDate: $preExpectedDate, expectedDate: $expectedDate, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  const Todo({
    this.id,
    this.name = '',
    this.span = 0,
    this.remind = true,
    this.time,
    this.count = 0,
    this.skipCount = 0,
    this.skipConsecutive = 0,
    this.categoryId,
    this.completeDate = const [],
    this.preExpectedDate,
    this.expectedDate,
    this.createdAt,
    this.updatedAt,
  });

  Todo copyWithNoId({
    int? id,
    String? name,
    int? span,
    bool? remind,
    int? time,
    int? count,
    int? skipCount,
    int? skipConsecutive,
    int? categoryId,
    List<DateTime>? completeDate,
    DateTime? preExpectedDate,
    DateTime? expectedDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id,
      name: name ?? this.name,
      span: span ?? this.span,
      remind: remind ?? this.remind,
      time: time ?? this.time,
      count: count ?? this.count,
      skipCount: skipCount ?? this.skipCount,
      skipConsecutive: skipConsecutive ?? this.skipConsecutive,
      categoryId: categoryId ?? this.categoryId,
      completeDate: completeDate ?? this.completeDate,
      preExpectedDate: preExpectedDate ?? this.preExpectedDate,
      expectedDate: expectedDate ?? this.expectedDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Todo copyWith({
    int? id,
    String? name,
    int? span,
    bool? remind,
    int? time,
    int? count,
    int? skipCount,
    int? skipConsecutive,
    int? Function()? categoryId,
    List<DateTime>? completeDate,
    DateTime? Function()? preExpectedDate,
    DateTime? Function()? expectedDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      span: span ?? this.span,
      remind: remind ?? this.remind,
      time: time ?? this.time,
      count: count ?? this.count,
      skipCount: skipCount ?? this.skipCount,
      skipConsecutive: skipConsecutive ?? this.skipConsecutive,
      categoryId: categoryId != null ? categoryId() : this.categoryId,
      completeDate: completeDate ?? this.completeDate,
      preExpectedDate:
          preExpectedDate != null ? preExpectedDate() : this.preExpectedDate,
      expectedDate: expectedDate != null ? expectedDate() : this.expectedDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
      'name': name,
      'span': span,
      'remind': remind ? 1 : 0,
      'time': time,
      'count': count,
      'skipCount': skipCount,
      'skipConsecutive': skipConsecutive,
      'categoryId': categoryId,
      'completeDate': completeDate.map((e) => e.toIso8601String()).join(","),
      'preExpectedDate': preExpectedDate?.toIso8601String(),
      'expectedDate': expectedDate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    List<DateTime> completeDate;
    if (('${map['completeDate']}').isEmpty) {
      completeDate = [];
    } else {
      completeDate = ('${map['completeDate']}')
          .split(',')
          .map((e) => DateTime.parse(e))
          .toList();
    }
    return Todo(
      id: map['id'] as int,
      name: map['name'] as String,
      span: map['span'] as int,
      remind: map['remind'] == 1 ? true : false,
      time: map['time'] as int?,
      count: map['count'] as int,
      skipCount: map['skipCount'] as int,
      skipConsecutive: map['skipConsecutive'] as int,
      categoryId: map['categoryId'],
      completeDate: completeDate,
      preExpectedDate: DateTime.tryParse(map['preExpectedDate'] ?? ''),
      expectedDate: DateTime.tryParse(map['expectedDate'] ?? ''),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
