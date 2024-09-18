// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_dialog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimeDialogState {
  /// 選んでいる時間
  int get time => throw _privateConstructorUsedError;

  /// Create a copy of TimeDialogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeDialogStateCopyWith<TimeDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeDialogStateCopyWith<$Res> {
  factory $TimeDialogStateCopyWith(
          TimeDialogState value, $Res Function(TimeDialogState) then) =
      _$TimeDialogStateCopyWithImpl<$Res, TimeDialogState>;
  @useResult
  $Res call({int time});
}

/// @nodoc
class _$TimeDialogStateCopyWithImpl<$Res, $Val extends TimeDialogState>
    implements $TimeDialogStateCopyWith<$Res> {
  _$TimeDialogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeDialogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeDialogStateImplCopyWith<$Res>
    implements $TimeDialogStateCopyWith<$Res> {
  factory _$$TimeDialogStateImplCopyWith(_$TimeDialogStateImpl value,
          $Res Function(_$TimeDialogStateImpl) then) =
      __$$TimeDialogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int time});
}

/// @nodoc
class __$$TimeDialogStateImplCopyWithImpl<$Res>
    extends _$TimeDialogStateCopyWithImpl<$Res, _$TimeDialogStateImpl>
    implements _$$TimeDialogStateImplCopyWith<$Res> {
  __$$TimeDialogStateImplCopyWithImpl(
      _$TimeDialogStateImpl _value, $Res Function(_$TimeDialogStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeDialogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
  }) {
    return _then(_$TimeDialogStateImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TimeDialogStateImpl implements _TimeDialogState {
  const _$TimeDialogStateImpl({this.time = 5});

  /// 選んでいる時間
  @override
  @JsonKey()
  final int time;

  @override
  String toString() {
    return 'TimeDialogState(time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeDialogStateImpl &&
            (identical(other.time, time) || other.time == time));
  }

  @override
  int get hashCode => Object.hash(runtimeType, time);

  /// Create a copy of TimeDialogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeDialogStateImplCopyWith<_$TimeDialogStateImpl> get copyWith =>
      __$$TimeDialogStateImplCopyWithImpl<_$TimeDialogStateImpl>(
          this, _$identity);
}

abstract class _TimeDialogState implements TimeDialogState {
  const factory _TimeDialogState({final int time}) = _$TimeDialogStateImpl;

  /// 選んでいる時間
  @override
  int get time;

  /// Create a copy of TimeDialogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeDialogStateImplCopyWith<_$TimeDialogStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
