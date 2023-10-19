// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_detail_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskDetailPageState {
  String get title => throw _privateConstructorUsedError;
  int get span => throw _privateConstructorUsedError;
  bool get remind => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  int? get time => throw _privateConstructorUsedError;
  DateTime? get nextDay => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskDetailPageStateCopyWith<TaskDetailPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDetailPageStateCopyWith<$Res> {
  factory $TaskDetailPageStateCopyWith(
          TaskDetailPageState value, $Res Function(TaskDetailPageState) then) =
      _$TaskDetailPageStateCopyWithImpl<$Res, TaskDetailPageState>;
  @useResult
  $Res call(
      {String title,
      int span,
      bool remind,
      Category? category,
      int? time,
      DateTime? nextDay});

  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$TaskDetailPageStateCopyWithImpl<$Res, $Val extends TaskDetailPageState>
    implements $TaskDetailPageStateCopyWith<$Res> {
  _$TaskDetailPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? span = null,
    Object? remind = null,
    Object? category = freezed,
    Object? time = freezed,
    Object? nextDay = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as int,
      remind: null == remind
          ? _value.remind
          : remind // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      nextDay: freezed == nextDay
          ? _value.nextDay
          : nextDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskDetailPageStateImplCopyWith<$Res>
    implements $TaskDetailPageStateCopyWith<$Res> {
  factory _$$TaskDetailPageStateImplCopyWith(_$TaskDetailPageStateImpl value,
          $Res Function(_$TaskDetailPageStateImpl) then) =
      __$$TaskDetailPageStateImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call(
      {String title,
      int span,
      bool remind,
      Category? category,
      int? time,
      DateTime? nextDay});

  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$TaskDetailPageStateImplCopyWithImpl<$Res>
    extends _$TaskDetailPageStateCopyWithImpl<$Res, _$TaskDetailPageStateImpl>
    implements _$$TaskDetailPageStateImplCopyWith<$Res> {
  __$$TaskDetailPageStateImplCopyWithImpl(_$TaskDetailPageStateImpl _value,
      $Res Function(_$TaskDetailPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? span = null,
    Object? remind = null,
    Object? category = freezed,
    Object? time = freezed,
    Object? nextDay = freezed,
  }) {
    return _then(_$TaskDetailPageStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as int,
      remind: null == remind
          ? _value.remind
          : remind // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      nextDay: freezed == nextDay
          ? _value.nextDay
          : nextDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$TaskDetailPageStateImpl implements _TaskDetailPageState {
  const _$TaskDetailPageStateImpl(
      {required this.title,
      required this.span,
      required this.remind,
      required this.category,
      required this.time,
      required this.nextDay});

  @override
  final String title;
  @override
  final int span;
  @override
  final bool remind;
  @override
  final Category? category;
  @override
  final int? time;
  @override
  final DateTime? nextDay;

  @override
  String toString() {
    return 'TaskDetailPageState(title: $title, span: $span, remind: $remind, category: $category, time: $time, nextDay: $nextDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDetailPageStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.span, span) || other.span == span) &&
            (identical(other.remind, remind) || other.remind == remind) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.nextDay, nextDay) || other.nextDay == nextDay));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, span, remind, category, time, nextDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDetailPageStateImplCopyWith<_$TaskDetailPageStateImpl> get copyWith =>
      __$$TaskDetailPageStateImplCopyWithImpl<_$TaskDetailPageStateImpl>(
          this, _$identity);
}

abstract class _TaskDetailPageState implements TaskDetailPageState {
  const factory _TaskDetailPageState(
      {required final String title,
      required final int span,
      required final bool remind,
      required final Category? category,
      required final int? time,
      required final DateTime? nextDay}) = _$TaskDetailPageStateImpl;

  @override
  String get title;
  @override
  int get span;
  @override
  bool get remind;
  @override
  Category? get category;
  @override
  int? get time;

  @override
  DateTime? get nextDay;

  @override
  @JsonKey(ignore: true)
  _$$TaskDetailPageStateImplCopyWith<_$TaskDetailPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TaskDetailPageArgs {
  Todo get todo => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskDetailPageArgsCopyWith<TaskDetailPageArgs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDetailPageArgsCopyWith<$Res> {
  factory $TaskDetailPageArgsCopyWith(
          TaskDetailPageArgs value, $Res Function(TaskDetailPageArgs) then) =
      _$TaskDetailPageArgsCopyWithImpl<$Res, TaskDetailPageArgs>;
  @useResult
  $Res call({Todo todo, bool isCompleted});
}

/// @nodoc
class _$TaskDetailPageArgsCopyWithImpl<$Res, $Val extends TaskDetailPageArgs>
    implements $TaskDetailPageArgsCopyWith<$Res> {
  _$TaskDetailPageArgsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskDetailPageArgsImplCopyWith<$Res>
    implements $TaskDetailPageArgsCopyWith<$Res> {
  factory _$$TaskDetailPageArgsImplCopyWith(_$TaskDetailPageArgsImpl value,
          $Res Function(_$TaskDetailPageArgsImpl) then) =
      __$$TaskDetailPageArgsImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({Todo todo, bool isCompleted});
}

/// @nodoc
class __$$TaskDetailPageArgsImplCopyWithImpl<$Res>
    extends _$TaskDetailPageArgsCopyWithImpl<$Res, _$TaskDetailPageArgsImpl>
    implements _$$TaskDetailPageArgsImplCopyWith<$Res> {
  __$$TaskDetailPageArgsImplCopyWithImpl(_$TaskDetailPageArgsImpl _value,
      $Res Function(_$TaskDetailPageArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = null,
    Object? isCompleted = null,
  }) {
    return _then(_$TaskDetailPageArgsImpl(
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TaskDetailPageArgsImpl implements _TaskDetailPageArgs {
  const _$TaskDetailPageArgsImpl(
      {required this.todo, required this.isCompleted});

  @override
  final Todo todo;
  @override
  final bool isCompleted;

  @override
  String toString() {
    return 'TaskDetailPageArgs(todo: $todo, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDetailPageArgsImpl &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todo, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDetailPageArgsImplCopyWith<_$TaskDetailPageArgsImpl> get copyWith =>
      __$$TaskDetailPageArgsImplCopyWithImpl<_$TaskDetailPageArgsImpl>(
          this, _$identity);
}

abstract class _TaskDetailPageArgs implements TaskDetailPageArgs {
  const factory _TaskDetailPageArgs(
      {required final Todo todo,
      required final bool isCompleted}) = _$TaskDetailPageArgsImpl;

  @override
  Todo get todo;

  @override
  bool get isCompleted;

  @override
  @JsonKey(ignore: true)
  _$$TaskDetailPageArgsImplCopyWith<_$TaskDetailPageArgsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
