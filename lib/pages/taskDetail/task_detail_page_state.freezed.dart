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
  /// タスク
  Todo get todo => throw _privateConstructorUsedError;

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
  $Res call({Todo todo});
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
    Object? todo = null,
  }) {
    return _then(_value.copyWith(
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskDetailPageStateCopyWith<$Res>
    implements $TaskDetailPageStateCopyWith<$Res> {
  factory _$$_TaskDetailPageStateCopyWith(_$_TaskDetailPageState value,
          $Res Function(_$_TaskDetailPageState) then) =
      __$$_TaskDetailPageStateCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({Todo todo});
}

/// @nodoc
class __$$_TaskDetailPageStateCopyWithImpl<$Res>
    extends _$TaskDetailPageStateCopyWithImpl<$Res, _$_TaskDetailPageState>
    implements _$$_TaskDetailPageStateCopyWith<$Res> {
  __$$_TaskDetailPageStateCopyWithImpl(_$_TaskDetailPageState _value,
      $Res Function(_$_TaskDetailPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = null,
  }) {
    return _then(_$_TaskDetailPageState(
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
    ));
  }
}

/// @nodoc

class _$_TaskDetailPageState implements _TaskDetailPageState {
  const _$_TaskDetailPageState({required this.todo});

  /// タスク
  @override
  final Todo todo;

  @override
  String toString() {
    return 'TaskDetailPageState(todo: $todo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskDetailPageState &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskDetailPageStateCopyWith<_$_TaskDetailPageState> get copyWith =>
      __$$_TaskDetailPageStateCopyWithImpl<_$_TaskDetailPageState>(
          this, _$identity);
}

abstract class _TaskDetailPageState implements TaskDetailPageState {
  const factory _TaskDetailPageState({required final Todo todo}) =
      _$_TaskDetailPageState;

  @override

  /// タスク
  Todo get todo;

  @override
  @JsonKey(ignore: true)
  _$$_TaskDetailPageStateCopyWith<_$_TaskDetailPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
