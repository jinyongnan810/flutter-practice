// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_name.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserName _$UserNameFromJson(Map<String, dynamic> json) {
  return _UserName.fromJson(json);
}

/// @nodoc
mixin _$UserName {
  String get title => throw _privateConstructorUsedError;
  String get first => throw _privateConstructorUsedError;
  String get last => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserNameCopyWith<UserName> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNameCopyWith<$Res> {
  factory $UserNameCopyWith(UserName value, $Res Function(UserName) then) =
      _$UserNameCopyWithImpl<$Res>;
  $Res call({String title, String first, String last});
}

/// @nodoc
class _$UserNameCopyWithImpl<$Res> implements $UserNameCopyWith<$Res> {
  _$UserNameCopyWithImpl(this._value, this._then);

  final UserName _value;
  // ignore: unused_field
  final $Res Function(UserName) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? first = freezed,
    Object? last = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      first: first == freezed
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as String,
      last: last == freezed
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserNameCopyWith<$Res> implements $UserNameCopyWith<$Res> {
  factory _$$_UserNameCopyWith(
          _$_UserName value, $Res Function(_$_UserName) then) =
      __$$_UserNameCopyWithImpl<$Res>;
  @override
  $Res call({String title, String first, String last});
}

/// @nodoc
class __$$_UserNameCopyWithImpl<$Res> extends _$UserNameCopyWithImpl<$Res>
    implements _$$_UserNameCopyWith<$Res> {
  __$$_UserNameCopyWithImpl(
      _$_UserName _value, $Res Function(_$_UserName) _then)
      : super(_value, (v) => _then(v as _$_UserName));

  @override
  _$_UserName get _value => super._value as _$_UserName;

  @override
  $Res call({
    Object? title = freezed,
    Object? first = freezed,
    Object? last = freezed,
  }) {
    return _then(_$_UserName(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      first: first == freezed
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as String,
      last: last == freezed
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserName with DiagnosticableTreeMixin implements _UserName {
  const _$_UserName(
      {required this.title, required this.first, required this.last});

  factory _$_UserName.fromJson(Map<String, dynamic> json) =>
      _$$_UserNameFromJson(json);

  @override
  final String title;
  @override
  final String first;
  @override
  final String last;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserName(title: $title, first: $first, last: $last)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserName'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('first', first))
      ..add(DiagnosticsProperty('last', last));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserName &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.first, first) &&
            const DeepCollectionEquality().equals(other.last, last));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(first),
      const DeepCollectionEquality().hash(last));

  @JsonKey(ignore: true)
  @override
  _$$_UserNameCopyWith<_$_UserName> get copyWith =>
      __$$_UserNameCopyWithImpl<_$_UserName>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserNameToJson(this);
  }
}

abstract class _UserName implements UserName {
  const factory _UserName(
      {required final String title,
      required final String first,
      required final String last}) = _$_UserName;

  factory _UserName.fromJson(Map<String, dynamic> json) = _$_UserName.fromJson;

  @override
  String get title;
  @override
  String get first;
  @override
  String get last;
  @override
  @JsonKey(ignore: true)
  _$$_UserNameCopyWith<_$_UserName> get copyWith =>
      throw _privateConstructorUsedError;
}
