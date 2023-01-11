import 'dart:ui';

class Todo {
  /// 管理ID
  final int? id;

  /// タスク名
  final String name;

  /// スパン　○日に一回
  final int span;

  /// リマインド
  final bool remind;

  /// タスクに要する時間
  final int time;

  /// これまでの実施回数
  final int count;

  /// タスクのスキップ回数
  final int skipCount;

  /// タスクの連続スキップ回数
  final int skipConsecutive;

  /// タスク完了したか
  final bool isCompleted;

  /// カテゴリID（カラーコード）
  final List<Color> categoryId;

  /// 次回実施日
  final DateTime date;

  /// 初回実施日
  final DateTime beginDate;

  /// 作成日時
  final DateTime? createdAt;

  /// 更新日時
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Todo{id: $id, name: $name, span: $span, remind: $remind, time: $time, count: $count, skipCount: $skipCount, skipConsecutive: $skipConsecutive, isCompleted: $isCompleted, categoryId: $categoryId, date: $date, beginDate: $beginDate, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  const Todo({
    this.id,
    required this.name,
    required this.span,
    required this.remind,
    required this.time,
    this.count = 0,
    this.skipCount = 0,
    this.skipConsecutive = 0,
    this.isCompleted = false,
    required this.categoryId,
    required this.date,
    required this.beginDate,
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
    bool? isCompleted,
    List<Color>? categoryId,
    DateTime? date,
    DateTime? beginDate,
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
      beginDate: beginDate ?? this.beginDate,
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
    bool? isCompleted,
    List<Color>? categoryId,
    DateTime? date,
    DateTime? beginDate,
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
      beginDate: beginDate ?? this.beginDate,
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
      'isCompleted': isCompleted ? 1:0,
      'categoryId': categoryId.map((e) => e.value).join(","),
      'date': date.toIso8601String(),
      'beginDate': beginDate.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    List<Color> categoryId;
    if (('${map['categoryId']}').isEmpty) {
      categoryId = [];
    } else {
      categoryId = ('${map['categoryId']}')
          .split(',')
          .map((e) => Color(int.parse(e)))
          .toList();
    }
    return Todo(
      id: map['id'] as int,
      name: map['name'] as String,
      span: map['span'] as int,
      remind: map['remind'] == 1 ? true : false,
      time: map['time'] as int,
      count: map['count'] as int,
      skipCount: map['skipCount'] as int,
      skipConsecutive: map['skipConsecutive'] as int,
      isCompleted: map['isCompleted'] == 1 ? true : false,
      categoryId: categoryId,
      date: DateTime.parse(map['date']),
      beginDate: DateTime.parse(map['beginDate']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
