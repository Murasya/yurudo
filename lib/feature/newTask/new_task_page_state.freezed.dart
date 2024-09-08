// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_task_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewTaskPageState {
  String get name => throw _privateConstructorUsedError;
  int? get span => throw _privateConstructorUsedError;
  bool get remind => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  int? get time => throw _privateConstructorUsedError;
  DateTime? get firstDay => throw _privateConstructorUsedError;
  dynamic get hasError => throw _privateConstructorUsedError;
  dynamic get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewTaskPageStateCopyWith<NewTaskPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewTaskPageStateCopyWith<$Res> {
  factory $NewTaskPageStateCopyWith(
          NewTaskPageState value, $Res Function(NewTaskPageState) then) =
      _$NewTaskPageStateCopyWithImpl<$Res, NewTaskPageState>;
  @useResult
  $Res call(
      {String name,
      int? span,
      bool remind,
      Category? category,
      int? time,
      DateTime? firstDay,
      dynamic hasError,
      dynamic errorMessage});

  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$NewTaskPageStateCopyWithImpl<$Res, $Val extends NewTaskPageState>
    implements $NewTaskPageStateCopyWith<$Res> {
  _$NewTaskPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? span = freezed,
    Object? remind = null,
    Object? category = freezed,
    Object? time = freezed,
    Object? firstDay = freezed,
    Object? hasError = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      span: freezed == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as int?,
      remind: null == remind
          ? _value.remind
          : remind // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      firstDay: freezed == firstDay
          ? _value.firstDay
          : firstDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasError: freezed == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as dynamic,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NewTaskPageStateImplCopyWith<$Res>
    implements $NewTaskPageStateCopyWith<$Res> {
  factory _$$NewTaskPageStateImplCopyWith(_$NewTaskPageStateImpl value,
          $Res Function(_$NewTaskPageStateImpl) then) =
      __$$NewTaskPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int? span,
      bool remind,
      Category? category,
      int? time,
      DateTime? firstDay,
      dynamic hasError,
      dynamic errorMessage});

  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$NewTaskPageStateImplCopyWithImpl<$Res>
    extends _$NewTaskPageStateCopyWithImpl<$Res, _$NewTaskPageStateImpl>
    implements _$$NewTaskPageStateImplCopyWith<$Res> {
  __$$NewTaskPageStateImplCopyWithImpl(_$NewTaskPageStateImpl _value,
      $Res Function(_$NewTaskPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? span = freezed,
    Object? remind = null,
    Object? category = freezed,
    Object? time = freezed,
    Object? firstDay = freezed,
    Object? hasError = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$NewTaskPageStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      span: freezed == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as int?,
      remind: null == remind
          ? _value.remind
          : remind // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int?,
      firstDay: freezed == firstDay
          ? _value.firstDay
          : firstDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasError: freezed == hasError ? _value.hasError! : hasError,
      errorMessage:
          freezed == errorMessage ? _value.errorMessage! : errorMessage,
    ));
  }
}

/// @nodoc

class _$NewTaskPageStateImpl implements _NewTaskPageState {
  const _$NewTaskPageStateImpl(
      {required this.name,
      required this.span,
      required this.remind,
      this.category = null,
      this.time = null,
      required this.firstDay,
      this.hasError = false,
      this.errorMessage = ''});

  @override
  final String name;
  @override
  final int? span;
  @override
  final bool remind;
  @override
  @JsonKey()
  final Category? category;
  @override
  @JsonKey()
  final int? time;
  @override
  final DateTime? firstDay;
  @override
  @JsonKey()
  final dynamic hasError;
  @override
  @JsonKey()
  final dynamic errorMessage;

  @override
  String toString() {
    return 'NewTaskPageState(name: $name, span: $span, remind: $remind, category: $category, time: $time, firstDay: $firstDay, hasError: $hasError, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewTaskPageStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.span, span) || other.span == span) &&
            (identical(other.remind, remind) || other.remind == remind) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.firstDay, firstDay) ||
                other.firstDay == firstDay) &&
            const DeepCollectionEquality().equals(other.hasError, hasError) &&
            const DeepCollectionEquality()
                .equals(other.errorMessage, errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      span,
      remind,
      category,
      time,
      firstDay,
      const DeepCollectionEquality().hash(hasError),
      const DeepCollectionEquality().hash(errorMessage));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewTaskPageStateImplCopyWith<_$NewTaskPageStateImpl> get copyWith =>
      __$$NewTaskPageStateImplCopyWithImpl<_$NewTaskPageStateImpl>(
          this, _$identity);
}

abstract class _NewTaskPageState implements NewTaskPageState {
  const factory _NewTaskPageState(
      {required final String name,
      required final int? span,
      required final bool remind,
      final Category? category,
      final int? time,
      required final DateTime? firstDay,
      final dynamic hasError,
      final dynamic errorMessage}) = _$NewTaskPageStateImpl;

  @override
  String get name;
  @override
  int? get span;
  @override
  bool get remind;
  @override
  Category? get category;
  @override
  int? get time;
  @override
  DateTime? get firstDay;
  @override
  dynamic get hasError;
  @override
  dynamic get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$NewTaskPageStateImplCopyWith<_$NewTaskPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
