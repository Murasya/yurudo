// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ListPageState {
  SortType get sortType => throw _privateConstructorUsedError;
  List<int> get filterType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListPageStateCopyWith<ListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListPageStateCopyWith<$Res> {
  factory $ListPageStateCopyWith(
          ListPageState value, $Res Function(ListPageState) then) =
      _$ListPageStateCopyWithImpl<$Res, ListPageState>;
  @useResult
  $Res call({SortType sortType, List<int> filterType});
}

/// @nodoc
class _$ListPageStateCopyWithImpl<$Res, $Val extends ListPageState>
    implements $ListPageStateCopyWith<$Res> {
  _$ListPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortType = null,
    Object? filterType = null,
  }) {
    return _then(_value.copyWith(
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as SortType,
      filterType: null == filterType
          ? _value.filterType
          : filterType // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ListPageStateCopyWith<$Res>
    implements $ListPageStateCopyWith<$Res> {
  factory _$$_ListPageStateCopyWith(
          _$_ListPageState value, $Res Function(_$_ListPageState) then) =
      __$$_ListPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SortType sortType, List<int> filterType});
}

/// @nodoc
class __$$_ListPageStateCopyWithImpl<$Res>
    extends _$ListPageStateCopyWithImpl<$Res, _$_ListPageState>
    implements _$$_ListPageStateCopyWith<$Res> {
  __$$_ListPageStateCopyWithImpl(
      _$_ListPageState _value, $Res Function(_$_ListPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortType = null,
    Object? filterType = null,
  }) {
    return _then(_$_ListPageState(
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as SortType,
      filterType: null == filterType
          ? _value._filterType
          : filterType // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$_ListPageState implements _ListPageState {
  const _$_ListPageState(
      {this.sortType = SortType.addDayAsc,
      final List<int> filterType = const []})
      : _filterType = filterType;

  @override
  @JsonKey()
  final SortType sortType;
  final List<int> _filterType;
  @override
  @JsonKey()
  List<int> get filterType {
    if (_filterType is EqualUnmodifiableListView) return _filterType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filterType);
  }

  @override
  String toString() {
    return 'ListPageState(sortType: $sortType, filterType: $filterType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ListPageState &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            const DeepCollectionEquality()
                .equals(other._filterType, _filterType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, sortType, const DeepCollectionEquality().hash(_filterType));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ListPageStateCopyWith<_$_ListPageState> get copyWith =>
      __$$_ListPageStateCopyWithImpl<_$_ListPageState>(this, _$identity);
}

abstract class _ListPageState implements ListPageState {
  const factory _ListPageState(
      {final SortType sortType, final List<int> filterType}) = _$_ListPageState;

  @override
  SortType get sortType;
  @override
  List<int> get filterType;
  @override
  @JsonKey(ignore: true)
  _$$_ListPageStateCopyWith<_$_ListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
