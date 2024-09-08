// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_dialog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DateDialogState {
  /// 選んでいる日にち
  DateTime get selectDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DateDialogStateCopyWith<DateDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateDialogStateCopyWith<$Res> {
  factory $DateDialogStateCopyWith(
          DateDialogState value, $Res Function(DateDialogState) then) =
      _$DateDialogStateCopyWithImpl<$Res, DateDialogState>;
  @useResult
  $Res call({DateTime selectDate});
}

/// @nodoc
class _$DateDialogStateCopyWithImpl<$Res, $Val extends DateDialogState>
    implements $DateDialogStateCopyWith<$Res> {
  _$DateDialogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectDate = null,
  }) {
    return _then(_value.copyWith(
      selectDate: null == selectDate
          ? _value.selectDate
          : selectDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateDialogStateImplCopyWith<$Res>
    implements $DateDialogStateCopyWith<$Res> {
  factory _$$DateDialogStateImplCopyWith(_$DateDialogStateImpl value,
          $Res Function(_$DateDialogStateImpl) then) =
      __$$DateDialogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectDate});
}

/// @nodoc
class __$$DateDialogStateImplCopyWithImpl<$Res>
    extends _$DateDialogStateCopyWithImpl<$Res, _$DateDialogStateImpl>
    implements _$$DateDialogStateImplCopyWith<$Res> {
  __$$DateDialogStateImplCopyWithImpl(
      _$DateDialogStateImpl _value, $Res Function(_$DateDialogStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectDate = null,
  }) {
    return _then(_$DateDialogStateImpl(
      selectDate: null == selectDate
          ? _value.selectDate
          : selectDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DateDialogStateImpl implements _DateDialogState {
  const _$DateDialogStateImpl({required this.selectDate});

  /// 選んでいる日にち
  @override
  final DateTime selectDate;

  @override
  String toString() {
    return 'DateDialogState(selectDate: $selectDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateDialogStateImpl &&
            (identical(other.selectDate, selectDate) ||
                other.selectDate == selectDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DateDialogStateImplCopyWith<_$DateDialogStateImpl> get copyWith =>
      __$$DateDialogStateImplCopyWithImpl<_$DateDialogStateImpl>(
          this, _$identity);
}

abstract class _DateDialogState implements DateDialogState {
  const factory _DateDialogState({required final DateTime selectDate}) =
      _$DateDialogStateImpl;

  @override

  /// 選んでいる日にち
  DateTime get selectDate;
  @override
  @JsonKey(ignore: true)
  _$$DateDialogStateImplCopyWith<_$DateDialogStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
