// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_dialog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoryDialogState {
  /// 選んでいるボタンの数字
  int? get selectButtonNum => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryDialogStateCopyWith<CategoryDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryDialogStateCopyWith<$Res> {
  factory $CategoryDialogStateCopyWith(
          CategoryDialogState value, $Res Function(CategoryDialogState) then) =
      _$CategoryDialogStateCopyWithImpl<$Res, CategoryDialogState>;
  @useResult
  $Res call({int? selectButtonNum});
}

/// @nodoc
class _$CategoryDialogStateCopyWithImpl<$Res, $Val extends CategoryDialogState>
    implements $CategoryDialogStateCopyWith<$Res> {
  _$CategoryDialogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectButtonNum = freezed,
  }) {
    return _then(_value.copyWith(
      selectButtonNum: freezed == selectButtonNum
          ? _value.selectButtonNum
          : selectButtonNum // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryDialogStateImplCopyWith<$Res>
    implements $CategoryDialogStateCopyWith<$Res> {
  factory _$$CategoryDialogStateImplCopyWith(_$CategoryDialogStateImpl value,
          $Res Function(_$CategoryDialogStateImpl) then) =
      __$$CategoryDialogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? selectButtonNum});
}

/// @nodoc
class __$$CategoryDialogStateImplCopyWithImpl<$Res>
    extends _$CategoryDialogStateCopyWithImpl<$Res, _$CategoryDialogStateImpl>
    implements _$$CategoryDialogStateImplCopyWith<$Res> {
  __$$CategoryDialogStateImplCopyWithImpl(_$CategoryDialogStateImpl _value,
      $Res Function(_$CategoryDialogStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectButtonNum = freezed,
  }) {
    return _then(_$CategoryDialogStateImpl(
      selectButtonNum: freezed == selectButtonNum
          ? _value.selectButtonNum
          : selectButtonNum // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CategoryDialogStateImpl implements _CategoryDialogState {
  const _$CategoryDialogStateImpl({this.selectButtonNum = null});

  /// 選んでいるボタンの数字
  @override
  @JsonKey()
  final int? selectButtonNum;

  @override
  String toString() {
    return 'CategoryDialogState(selectButtonNum: $selectButtonNum)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryDialogStateImpl &&
            (identical(other.selectButtonNum, selectButtonNum) ||
                other.selectButtonNum == selectButtonNum));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectButtonNum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryDialogStateImplCopyWith<_$CategoryDialogStateImpl> get copyWith =>
      __$$CategoryDialogStateImplCopyWithImpl<_$CategoryDialogStateImpl>(
          this, _$identity);
}

abstract class _CategoryDialogState implements CategoryDialogState {
  const factory _CategoryDialogState({final int? selectButtonNum}) =
      _$CategoryDialogStateImpl;

  @override

  /// 選んでいるボタンの数字
  int? get selectButtonNum;
  @override
  @JsonKey(ignore: true)
  _$$CategoryDialogStateImplCopyWith<_$CategoryDialogStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
