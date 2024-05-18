// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metro.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Metro _$MetroFromJson(Map<String, dynamic> json) {
  return _Metro.fromJson(json);
}

/// @nodoc
mixin _$Metro {
  String get line => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  num? get code => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MetroCopyWith<Metro> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetroCopyWith<$Res> {
  factory $MetroCopyWith(Metro value, $Res Function(Metro) then) =
      _$MetroCopyWithImpl<$Res, Metro>;
  @useResult
  $Res call({String line, String name, num? code, double lat, double lng});
}

/// @nodoc
class _$MetroCopyWithImpl<$Res, $Val extends Metro>
    implements $MetroCopyWith<$Res> {
  _$MetroCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line = null,
    Object? name = null,
    Object? code = freezed,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_value.copyWith(
      line: null == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as num?,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MetroImplCopyWith<$Res> implements $MetroCopyWith<$Res> {
  factory _$$MetroImplCopyWith(
          _$MetroImpl value, $Res Function(_$MetroImpl) then) =
      __$$MetroImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String line, String name, num? code, double lat, double lng});
}

/// @nodoc
class __$$MetroImplCopyWithImpl<$Res>
    extends _$MetroCopyWithImpl<$Res, _$MetroImpl>
    implements _$$MetroImplCopyWith<$Res> {
  __$$MetroImplCopyWithImpl(
      _$MetroImpl _value, $Res Function(_$MetroImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line = null,
    Object? name = null,
    Object? code = freezed,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(_$MetroImpl(
      line: null == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as num?,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MetroImpl implements _Metro {
  const _$MetroImpl(
      {required this.line,
      required this.name,
      required this.code,
      required this.lat,
      required this.lng});

  factory _$MetroImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetroImplFromJson(json);

  @override
  final String line;
  @override
  final String name;
  @override
  final num? code;
  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'Metro(line: $line, name: $name, code: $code, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetroImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, line, name, code, lat, lng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MetroImplCopyWith<_$MetroImpl> get copyWith =>
      __$$MetroImplCopyWithImpl<_$MetroImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetroImplToJson(
      this,
    );
  }
}

abstract class _Metro implements Metro {
  const factory _Metro(
      {required final String line,
      required final String name,
      required final num? code,
      required final double lat,
      required final double lng}) = _$MetroImpl;

  factory _Metro.fromJson(Map<String, dynamic> json) = _$MetroImpl.fromJson;

  @override
  String get line;
  @override
  String get name;
  @override
  num? get code;
  @override
  double get lat;
  @override
  double get lng;
  @override
  @JsonKey(ignore: true)
  _$$MetroImplCopyWith<_$MetroImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
