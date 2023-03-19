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

  /// タスク完了したか
  final List<bool> isCompleted;

  /// カテゴリID
  final int? categoryId;

  /// 実施日
  final List<DateTime> date;

  /// 作成日時
  final DateTime? createdAt;

  /// 更新日時
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Todo{id: $id, name: $name, span: $span, remind: $remind, time: $time, count: $count, skipCount: $skipCount, skipConsecutive: $skipConsecutive, isCompleted: $isCompleted, categoryId: $categoryId, date: $date, createdAt: $createdAt, updatedAt: $updatedAt}';
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
    this.isCompleted = const [],
    this.categoryId,
    this.date = const [],
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
    List<bool>? isCompleted,
    int? categoryId,
    List<DateTime>? date,
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
      isCompleted: isCompleted ?? this.isCompleted,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
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
    List<bool>? isCompleted,
    int? categoryId,
    List<DateTime>? date,
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
      isCompleted: isCompleted ?? this.isCompleted,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
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
      'isCompleted': isCompleted.map((e) => e ? 1 : 0).join(","),
      'categoryId': categoryId,
      'date': date.map((e) => e.toIso8601String()).join(","),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    List<DateTime> date;
    if (('${map['date']}').isEmpty) {
      date = [];
    } else {
      date =
          ('${map['date']}').split(',').map((e) => DateTime.parse(e)).toList();
    }
    List<bool> isCompleted;
    if (('${map['isCompleted']}').isEmpty) {
      isCompleted = [];
    } else {
      isCompleted = ('${map['isCompleted']}')
          .split(',')
          .map((e) => e == '1' ? true : false)
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
      isCompleted: isCompleted,
      categoryId: map['categoryId'],
      date: date,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
