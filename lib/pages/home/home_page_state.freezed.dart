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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomePageState {
  /// タスクリスト
  List<Todo> get todoList => throw _privateConstructorUsedError;

  /// 絞り込み
  FilterType get filter => throw _privateConstructorUsedError;

  /// 表示期間（0: 全て、1: 今日、2: 今週、3: 今月）
  int get displayTerm => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res, HomePageState>;

  @useResult
  $Res call({List<Todo> todoList, FilterType filter, int displayTerm});
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res, $Val extends HomePageState>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoList = null,
    Object? filter = null,
    Object? displayTerm = null,
  }) {
    return _then(_value.copyWith(
      todoList: null == todoList
          ? _value.todoList
          : todoList // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FilterType,
      displayTerm: null == displayTerm
          ? _value.displayTerm
          : displayTerm // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomePageStateCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$$_HomePageStateCopyWith(
          _$_HomePageState value, $Res Function(_$_HomePageState) then) =
      __$$_HomePageStateCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({List<Todo> todoList, FilterType filter, int displayTerm});
}

/// @nodoc
class __$$_HomePageStateCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res, _$_HomePageState>
    implements _$$_HomePageStateCopyWith<$Res> {
  __$$_HomePageStateCopyWithImpl(
      _$_HomePageState _value, $Res Function(_$_HomePageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoList = null,
    Object? filter = null,
    Object? displayTerm = null,
  }) {
    return _then(_$_HomePageState(
      todoList: null == todoList
          ? _value._todoList
          : todoList // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FilterType,
      displayTerm: null == displayTerm
          ? _value.displayTerm
          : displayTerm // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_HomePageState implements _HomePageState {
  _$_HomePageState(
      {final List<Todo> todoList = const [],
      this.filter = FilterType.all,
      this.displayTerm = 0})
      : _todoList = todoList;

  /// タスクリスト
  final List<Todo> _todoList;

  /// タスクリスト
  @override
  @JsonKey()
  List<Todo> get todoList {
    if (_todoList is EqualUnmodifiableListView) return _todoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todoList);
  }

  /// 絞り込み
  @override
  @JsonKey()
  final FilterType filter;

  /// 表示期間（0: 全て、1: 今日、2: 今週、3: 今月）
  @override
  @JsonKey()
  final int displayTerm;

  @override
  String toString() {
    return 'HomePageState(todoList: $todoList, filter: $filter, displayTerm: $displayTerm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomePageState &&
            const DeepCollectionEquality().equals(other._todoList, _todoList) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.displayTerm, displayTerm) ||
                other.displayTerm == displayTerm));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_todoList), filter, displayTerm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomePageStateCopyWith<_$_HomePageState> get copyWith =>
      __$$_HomePageStateCopyWithImpl<_$_HomePageState>(this, _$identity);
}

abstract class _HomePageState implements HomePageState {
  factory _HomePageState(
      {final List<Todo> todoList,
      final FilterType filter,
      final int displayTerm}) = _$_HomePageState;

  @override

  /// タスクリスト
  List<Todo> get todoList;

  @override

  /// 絞り込み
  FilterType get filter;

  @override

  /// 表示期間（0: 全て、1: 今日、2: 今週、3: 今月）
  int get displayTerm;

  @override
  @JsonKey(ignore: true)
  _$$_HomePageStateCopyWith<_$_HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
