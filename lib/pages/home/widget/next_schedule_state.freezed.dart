// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'next_schedule_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NextScheduleArgs {
  Todo get todo => throw _privateConstructorUsedError;
  DateTime get completeDay => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NextScheduleArgsCopyWith<NextScheduleArgs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NextScheduleArgsCopyWith<$Res> {
  factory $NextScheduleArgsCopyWith(
          NextScheduleArgs value, $Res Function(NextScheduleArgs) then) =
      _$NextScheduleArgsCopyWithImpl<$Res, NextScheduleArgs>;
  @useResult
  $Res call({Todo todo, DateTime completeDay});
}

/// @nodoc
class _$NextScheduleArgsCopyWithImpl<$Res, $Val extends NextScheduleArgs>
    implements $NextScheduleArgsCopyWith<$Res> {
  _$NextScheduleArgsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = null,
    Object? completeDay = null,
  }) {
    return _then(_value.copyWith(
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
      completeDay: null == completeDay
          ? _value.completeDay
          : completeDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NextScheduleArgsCopyWith<$Res>
    implements $NextScheduleArgsCopyWith<$Res> {
  factory _$$_NextScheduleArgsCopyWith(
          _$_NextScheduleArgs value, $Res Function(_$_NextScheduleArgs) then) =
      __$$_NextScheduleArgsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Todo todo, DateTime completeDay});
}

/// @nodoc
class __$$_NextScheduleArgsCopyWithImpl<$Res>
    extends _$NextScheduleArgsCopyWithImpl<$Res, _$_NextScheduleArgs>
    implements _$$_NextScheduleArgsCopyWith<$Res> {
  __$$_NextScheduleArgsCopyWithImpl(
      _$_NextScheduleArgs _value, $Res Function(_$_NextScheduleArgs) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = null,
    Object? completeDay = null,
  }) {
    return _then(_$_NextScheduleArgs(
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
      completeDay: null == completeDay
          ? _value.completeDay
          : completeDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_NextScheduleArgs implements _NextScheduleArgs {
  const _$_NextScheduleArgs({required this.todo, required this.completeDay});

  @override
  final Todo todo;
  @override
  final DateTime completeDay;

  @override
  String toString() {
    return 'NextScheduleArgs(todo: $todo, completeDay: $completeDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NextScheduleArgs &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.completeDay, completeDay) ||
                other.completeDay == completeDay));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todo, completeDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NextScheduleArgsCopyWith<_$_NextScheduleArgs> get copyWith =>
      __$$_NextScheduleArgsCopyWithImpl<_$_NextScheduleArgs>(this, _$identity);
}

abstract class _NextScheduleArgs implements NextScheduleArgs {
  const factory _NextScheduleArgs(
      {required final Todo todo,
      required final DateTime completeDay}) = _$_NextScheduleArgs;

  @override
  Todo get todo;
  @override
  DateTime get completeDay;
  @override
  @JsonKey(ignore: true)
  _$$_NextScheduleArgsCopyWith<_$_NextScheduleArgs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NextScheduleState {
  DateTime get displayMonth => throw _privateConstructorUsedError;
  DateTime get selectDay => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NextScheduleStateCopyWith<NextScheduleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NextScheduleStateCopyWith<$Res> {
  factory $NextScheduleStateCopyWith(
          NextScheduleState value, $Res Function(NextScheduleState) then) =
      _$NextScheduleStateCopyWithImpl<$Res, NextScheduleState>;
  @useResult
  $Res call({DateTime displayMonth, DateTime selectDay});
}

/// @nodoc
class _$NextScheduleStateCopyWithImpl<$Res, $Val extends NextScheduleState>
    implements $NextScheduleStateCopyWith<$Res> {
  _$NextScheduleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayMonth = null,
    Object? selectDay = null,
  }) {
    return _then(_value.copyWith(
      displayMonth: null == displayMonth
          ? _value.displayMonth
          : displayMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectDay: null == selectDay
          ? _value.selectDay
          : selectDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NextScheduleStateCopyWith<$Res>
    implements $NextScheduleStateCopyWith<$Res> {
  factory _$$_NextScheduleStateCopyWith(_$_NextScheduleState value,
          $Res Function(_$_NextScheduleState) then) =
      __$$_NextScheduleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime displayMonth, DateTime selectDay});
}

/// @nodoc
class __$$_NextScheduleStateCopyWithImpl<$Res>
    extends _$NextScheduleStateCopyWithImpl<$Res, _$_NextScheduleState>
    implements _$$_NextScheduleStateCopyWith<$Res> {
  __$$_NextScheduleStateCopyWithImpl(
      _$_NextScheduleState _value, $Res Function(_$_NextScheduleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayMonth = null,
    Object? selectDay = null,
  }) {
    return _then(_$_NextScheduleState(
      displayMonth: null == displayMonth
          ? _value.displayMonth
          : displayMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectDay: null == selectDay
          ? _value.selectDay
          : selectDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_NextScheduleState implements _NextScheduleState {
  const _$_NextScheduleState(
      {required this.displayMonth, required this.selectDay});

  @override
  final DateTime displayMonth;
  @override
  final DateTime selectDay;

  @override
  String toString() {
    return 'NextScheduleState(displayMonth: $displayMonth, selectDay: $selectDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NextScheduleState &&
            (identical(other.displayMonth, displayMonth) ||
                other.displayMonth == displayMonth) &&
            (identical(other.selectDay, selectDay) ||
                other.selectDay == selectDay));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayMonth, selectDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NextScheduleStateCopyWith<_$_NextScheduleState> get copyWith =>
      __$$_NextScheduleStateCopyWithImpl<_$_NextScheduleState>(
          this, _$identity);
}

abstract class _NextScheduleState implements NextScheduleState {
  const factory _NextScheduleState(
      {required final DateTime displayMonth,
      required final DateTime selectDay}) = _$_NextScheduleState;

  @override
  DateTime get displayMonth;
  @override
  DateTime get selectDay;
  @override
  @JsonKey(ignore: true)
  _$$_NextScheduleStateCopyWith<_$_NextScheduleState> get copyWith =>
      throw _privateConstructorUsedError;
}
