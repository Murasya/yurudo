// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomePageState {
  /// 表示期間
  TermType get displayTerm => throw _privateConstructorUsedError;

  /// 今日
  DateTime get today => throw _privateConstructorUsedError;

  /// 表示しているページ番号
  int get pageIndexDay => throw _privateConstructorUsedError;
  int get pageIndexWeek => throw _privateConstructorUsedError;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res, HomePageState>;
  @useResult
  $Res call(
      {TermType displayTerm,
      DateTime today,
      int pageIndexDay,
      int pageIndexWeek});
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res, $Val extends HomePageState>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayTerm = null,
    Object? today = null,
    Object? pageIndexDay = null,
    Object? pageIndexWeek = null,
  }) {
    return _then(_value.copyWith(
      displayTerm: null == displayTerm
          ? _value.displayTerm
          : displayTerm // ignore: cast_nullable_to_non_nullable
              as TermType,
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pageIndexDay: null == pageIndexDay
          ? _value.pageIndexDay
          : pageIndexDay // ignore: cast_nullable_to_non_nullable
              as int,
      pageIndexWeek: null == pageIndexWeek
          ? _value.pageIndexWeek
          : pageIndexWeek // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomePageStateImplCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$$HomePageStateImplCopyWith(
          _$HomePageStateImpl value, $Res Function(_$HomePageStateImpl) then) =
      __$$HomePageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TermType displayTerm,
      DateTime today,
      int pageIndexDay,
      int pageIndexWeek});
}

/// @nodoc
class __$$HomePageStateImplCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res, _$HomePageStateImpl>
    implements _$$HomePageStateImplCopyWith<$Res> {
  __$$HomePageStateImplCopyWithImpl(
      _$HomePageStateImpl _value, $Res Function(_$HomePageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayTerm = null,
    Object? today = null,
    Object? pageIndexDay = null,
    Object? pageIndexWeek = null,
  }) {
    return _then(_$HomePageStateImpl(
      displayTerm: null == displayTerm
          ? _value.displayTerm
          : displayTerm // ignore: cast_nullable_to_non_nullable
              as TermType,
      today: null == today
          ? _value.today
          : today // ignore: cast_nullable_to_non_nullable
              as DateTime,
      pageIndexDay: null == pageIndexDay
          ? _value.pageIndexDay
          : pageIndexDay // ignore: cast_nullable_to_non_nullable
              as int,
      pageIndexWeek: null == pageIndexWeek
          ? _value.pageIndexWeek
          : pageIndexWeek // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HomePageStateImpl extends _HomePageState {
  const _$HomePageStateImpl(
      {this.displayTerm = TermType.day,
      required this.today,
      required this.pageIndexDay,
      required this.pageIndexWeek})
      : super._();

  /// 表示期間
  @override
  @JsonKey()
  final TermType displayTerm;

  /// 今日
  @override
  final DateTime today;

  /// 表示しているページ番号
  @override
  final int pageIndexDay;
  @override
  final int pageIndexWeek;

  @override
  String toString() {
    return 'HomePageState(displayTerm: $displayTerm, today: $today, pageIndexDay: $pageIndexDay, pageIndexWeek: $pageIndexWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomePageStateImpl &&
            (identical(other.displayTerm, displayTerm) ||
                other.displayTerm == displayTerm) &&
            (identical(other.today, today) || other.today == today) &&
            (identical(other.pageIndexDay, pageIndexDay) ||
                other.pageIndexDay == pageIndexDay) &&
            (identical(other.pageIndexWeek, pageIndexWeek) ||
                other.pageIndexWeek == pageIndexWeek));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, displayTerm, today, pageIndexDay, pageIndexWeek);

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomePageStateImplCopyWith<_$HomePageStateImpl> get copyWith =>
      __$$HomePageStateImplCopyWithImpl<_$HomePageStateImpl>(this, _$identity);
}

abstract class _HomePageState extends HomePageState {
  const factory _HomePageState(
      {final TermType displayTerm,
      required final DateTime today,
      required final int pageIndexDay,
      required final int pageIndexWeek}) = _$HomePageStateImpl;
  const _HomePageState._() : super._();

  /// 表示期間
  @override
  TermType get displayTerm;

  /// 今日
  @override
  DateTime get today;

  /// 表示しているページ番号
  @override
  int get pageIndexDay;
  @override
  int get pageIndexWeek;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomePageStateImplCopyWith<_$HomePageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
