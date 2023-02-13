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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewTaskPageState {
  Todo get todo => throw _privateConstructorUsedError;

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
  $Res call({Todo todo});
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
    Object? todo = null,
  }) {
    return _then(_value.copyWith(
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewTaskPageStateCopyWith<$Res>
    implements $NewTaskPageStateCopyWith<$Res> {
  factory _$$_NewTaskPageStateCopyWith(
          _$_NewTaskPageState value, $Res Function(_$_NewTaskPageState) then) =
      __$$_NewTaskPageStateCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({Todo todo});
}

/// @nodoc
class __$$_NewTaskPageStateCopyWithImpl<$Res>
    extends _$NewTaskPageStateCopyWithImpl<$Res, _$_NewTaskPageState>
    implements _$$_NewTaskPageStateCopyWith<$Res> {
  __$$_NewTaskPageStateCopyWithImpl(
      _$_NewTaskPageState _value, $Res Function(_$_NewTaskPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = null,
  }) {
    return _then(_$_NewTaskPageState(
      todo: null == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
    ));
  }
}

/// @nodoc

class _$_NewTaskPageState implements _NewTaskPageState {
  const _$_NewTaskPageState({required this.todo});

  @override
  final Todo todo;

  @override
  String toString() {
    return 'NewTaskPageState(todo: $todo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewTaskPageState &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewTaskPageStateCopyWith<_$_NewTaskPageState> get copyWith =>
      __$$_NewTaskPageStateCopyWithImpl<_$_NewTaskPageState>(this, _$identity);
}

abstract class _NewTaskPageState implements NewTaskPageState {
  const factory _NewTaskPageState({required final Todo todo}) =
      _$_NewTaskPageState;

  @override
  Todo get todo;

  @override
  @JsonKey(ignore: true)
  _$$_NewTaskPageStateCopyWith<_$_NewTaskPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
