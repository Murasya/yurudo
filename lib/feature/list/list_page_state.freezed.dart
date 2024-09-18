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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListPageState {
  SortType get sortType => throw _privateConstructorUsedError;
  List<int> get filterType => throw _privateConstructorUsedError;

  /// Create a copy of ListPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ListPageState
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$ListPageStateImplCopyWith<$Res>
    implements $ListPageStateCopyWith<$Res> {
  factory _$$ListPageStateImplCopyWith(
          _$ListPageStateImpl value, $Res Function(_$ListPageStateImpl) then) =
      __$$ListPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SortType sortType, List<int> filterType});
}

/// @nodoc
class __$$ListPageStateImplCopyWithImpl<$Res>
    extends _$ListPageStateCopyWithImpl<$Res, _$ListPageStateImpl>
    implements _$$ListPageStateImplCopyWith<$Res> {
  __$$ListPageStateImplCopyWithImpl(
      _$ListPageStateImpl _value, $Res Function(_$ListPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortType = null,
    Object? filterType = null,
  }) {
    return _then(_$ListPageStateImpl(
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

class _$ListPageStateImpl implements _ListPageState {
  const _$ListPageStateImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListPageStateImpl &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            const DeepCollectionEquality()
                .equals(other._filterType, _filterType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, sortType, const DeepCollectionEquality().hash(_filterType));

  /// Create a copy of ListPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListPageStateImplCopyWith<_$ListPageStateImpl> get copyWith =>
      __$$ListPageStateImplCopyWithImpl<_$ListPageStateImpl>(this, _$identity);
}

abstract class _ListPageState implements ListPageState {
  const factory _ListPageState(
      {final SortType sortType,
      final List<int> filterType}) = _$ListPageStateImpl;

  @override
  SortType get sortType;
  @override
  List<int> get filterType;

  /// Create a copy of ListPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListPageStateImplCopyWith<_$ListPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
