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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$NextScheduleArgsImplCopyWith<$Res>
    implements $NextScheduleArgsCopyWith<$Res> {
  factory _$$NextScheduleArgsImplCopyWith(_$NextScheduleArgsImpl value,
          $Res Function(_$NextScheduleArgsImpl) then) =
      __$$NextScheduleArgsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Todo todo, DateTime completeDay});
}

/// @nodoc
class __$$NextScheduleArgsImplCopyWithImpl<$Res>
    extends _$NextScheduleArgsCopyWithImpl<$Res, _$NextScheduleArgsImpl>
    implements _$$NextScheduleArgsImplCopyWith<$Res> {
  __$$NextScheduleArgsImplCopyWithImpl(_$NextScheduleArgsImpl _value,
      $Res Function(_$NextScheduleArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = null,
    Object? completeDay = null,
  }) {
    return _then(_$NextScheduleArgsImpl(
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

class _$NextScheduleArgsImpl implements _NextScheduleArgs {
  const _$NextScheduleArgsImpl({required this.todo, required this.completeDay});

  @override
  final Todo todo;
  @override
  final DateTime completeDay;

  @override
  String toString() {
    return 'NextScheduleArgs(todo: $todo, completeDay: $completeDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NextScheduleArgsImpl &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.completeDay, completeDay) ||
                other.completeDay == completeDay));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todo, completeDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NextScheduleArgsImplCopyWith<_$NextScheduleArgsImpl> get copyWith =>
      __$$NextScheduleArgsImplCopyWithImpl<_$NextScheduleArgsImpl>(
          this, _$identity);
}

abstract class _NextScheduleArgs implements NextScheduleArgs {
  const factory _NextScheduleArgs(
      {required final Todo todo,
      required final DateTime completeDay}) = _$NextScheduleArgsImpl;

  @override
  Todo get todo;
  @override
  DateTime get completeDay;
  @override
  @JsonKey(ignore: true)
  _$$NextScheduleArgsImplCopyWith<_$NextScheduleArgsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NextScheduleState {
  DateTime get displayMonth => throw _privateConstructorUsedError;
  DateTime get selectDay => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

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
  $Res call(
      {DateTime displayMonth,
      DateTime selectDay,
      bool hasError,
      String errorMessage});
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
    Object? hasError = null,
    Object? errorMessage = null,
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
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NextScheduleStateImplCopyWith<$Res>
    implements $NextScheduleStateCopyWith<$Res> {
  factory _$$NextScheduleStateImplCopyWith(_$NextScheduleStateImpl value,
          $Res Function(_$NextScheduleStateImpl) then) =
      __$$NextScheduleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime displayMonth,
      DateTime selectDay,
      bool hasError,
      String errorMessage});
}

/// @nodoc
class __$$NextScheduleStateImplCopyWithImpl<$Res>
    extends _$NextScheduleStateCopyWithImpl<$Res, _$NextScheduleStateImpl>
    implements _$$NextScheduleStateImplCopyWith<$Res> {
  __$$NextScheduleStateImplCopyWithImpl(_$NextScheduleStateImpl _value,
      $Res Function(_$NextScheduleStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayMonth = null,
    Object? selectDay = null,
    Object? hasError = null,
    Object? errorMessage = null,
  }) {
    return _then(_$NextScheduleStateImpl(
      displayMonth: null == displayMonth
          ? _value.displayMonth
          : displayMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectDay: null == selectDay
          ? _value.selectDay
          : selectDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NextScheduleStateImpl implements _NextScheduleState {
  const _$NextScheduleStateImpl(
      {required this.displayMonth,
      required this.selectDay,
      this.hasError = false,
      this.errorMessage = ''});

  @override
  final DateTime displayMonth;
  @override
  final DateTime selectDay;
  @override
  @JsonKey()
  final bool hasError;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'NextScheduleState(displayMonth: $displayMonth, selectDay: $selectDay, hasError: $hasError, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NextScheduleStateImpl &&
            (identical(other.displayMonth, displayMonth) ||
                other.displayMonth == displayMonth) &&
            (identical(other.selectDay, selectDay) ||
                other.selectDay == selectDay) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, displayMonth, selectDay, hasError, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NextScheduleStateImplCopyWith<_$NextScheduleStateImpl> get copyWith =>
      __$$NextScheduleStateImplCopyWithImpl<_$NextScheduleStateImpl>(
          this, _$identity);
}

abstract class _NextScheduleState implements NextScheduleState {
  const factory _NextScheduleState(
      {required final DateTime displayMonth,
      required final DateTime selectDay,
      final bool hasError,
      final String errorMessage}) = _$NextScheduleStateImpl;

  @override
  DateTime get displayMonth;
  @override
  DateTime get selectDay;
  @override
  bool get hasError;
  @override
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$NextScheduleStateImplCopyWith<_$NextScheduleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
