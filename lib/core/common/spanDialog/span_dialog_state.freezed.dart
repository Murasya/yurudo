// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'span_dialog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SpanDialogState {
  /// 選んでいる日にち
  int get span => throw _privateConstructorUsedError;

  /// 選んでいるスパンの種類
  SpanType get spanType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpanDialogStateCopyWith<SpanDialogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpanDialogStateCopyWith<$Res> {
  factory $SpanDialogStateCopyWith(
          SpanDialogState value, $Res Function(SpanDialogState) then) =
      _$SpanDialogStateCopyWithImpl<$Res, SpanDialogState>;

  @useResult
  $Res call({int span, SpanType spanType});
}

/// @nodoc
class _$SpanDialogStateCopyWithImpl<$Res, $Val extends SpanDialogState>
    implements $SpanDialogStateCopyWith<$Res> {
  _$SpanDialogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? span = null,
    Object? spanType = null,
  }) {
    return _then(_value.copyWith(
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as int,
      spanType: null == spanType
          ? _value.spanType
          : spanType // ignore: cast_nullable_to_non_nullable
              as SpanType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpanDialogStateImplCopyWith<$Res>
    implements $SpanDialogStateCopyWith<$Res> {
  factory _$$SpanDialogStateImplCopyWith(_$SpanDialogStateImpl value,
          $Res Function(_$SpanDialogStateImpl) then) =
      __$$SpanDialogStateImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({int span, SpanType spanType});
}

/// @nodoc
class __$$SpanDialogStateImplCopyWithImpl<$Res>
    extends _$SpanDialogStateCopyWithImpl<$Res, _$SpanDialogStateImpl>
    implements _$$SpanDialogStateImplCopyWith<$Res> {
  __$$SpanDialogStateImplCopyWithImpl(
      _$SpanDialogStateImpl _value, $Res Function(_$SpanDialogStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? span = null,
    Object? spanType = null,
  }) {
    return _then(_$SpanDialogStateImpl(
      span: null == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as int,
      spanType: null == spanType
          ? _value.spanType
          : spanType // ignore: cast_nullable_to_non_nullable
              as SpanType,
    ));
  }
}

/// @nodoc

class _$SpanDialogStateImpl implements _SpanDialogState {
  const _$SpanDialogStateImpl({this.span = 1, this.spanType = SpanType.day});

  /// 選んでいる日にち
  @override
  @JsonKey()
  final int span;

  /// 選んでいるスパンの種類
  @override
  @JsonKey()
  final SpanType spanType;

  @override
  String toString() {
    return 'SpanDialogState(span: $span, spanType: $spanType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpanDialogStateImpl &&
            (identical(other.span, span) || other.span == span) &&
            (identical(other.spanType, spanType) ||
                other.spanType == spanType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, span, spanType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpanDialogStateImplCopyWith<_$SpanDialogStateImpl> get copyWith =>
      __$$SpanDialogStateImplCopyWithImpl<_$SpanDialogStateImpl>(
          this, _$identity);
}

abstract class _SpanDialogState implements SpanDialogState {
  const factory _SpanDialogState({final int span, final SpanType spanType}) =
      _$SpanDialogStateImpl;

  @override

  /// 選んでいる日にち
  int get span;

  @override

  /// 選んでいるスパンの種類
  SpanType get spanType;

  @override
  @JsonKey(ignore: true)
  _$$SpanDialogStateImplCopyWith<_$SpanDialogStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
