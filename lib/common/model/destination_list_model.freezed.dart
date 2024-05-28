// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'destination_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DestinationListModel _$DestinationListModelFromJson(Map<String, dynamic> json) {
  return _DestinationListModel.fromJson(json);
}

/// @nodoc
mixin _$DestinationListModel {
  String get destination => throw _privateConstructorUsedError;
  bool get isTracking => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DestinationListModelCopyWith<DestinationListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DestinationListModelCopyWith<$Res> {
  factory $DestinationListModelCopyWith(DestinationListModel value,
          $Res Function(DestinationListModel) then) =
      _$DestinationListModelCopyWithImpl<$Res, DestinationListModel>;
  @useResult
  $Res call({String destination, bool isTracking});
}

/// @nodoc
class _$DestinationListModelCopyWithImpl<$Res,
        $Val extends DestinationListModel>
    implements $DestinationListModelCopyWith<$Res> {
  _$DestinationListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destination = null,
    Object? isTracking = null,
  }) {
    return _then(_value.copyWith(
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      isTracking: null == isTracking
          ? _value.isTracking
          : isTracking // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DestinationListModelImplCopyWith<$Res>
    implements $DestinationListModelCopyWith<$Res> {
  factory _$$DestinationListModelImplCopyWith(_$DestinationListModelImpl value,
          $Res Function(_$DestinationListModelImpl) then) =
      __$$DestinationListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String destination, bool isTracking});
}

/// @nodoc
class __$$DestinationListModelImplCopyWithImpl<$Res>
    extends _$DestinationListModelCopyWithImpl<$Res, _$DestinationListModelImpl>
    implements _$$DestinationListModelImplCopyWith<$Res> {
  __$$DestinationListModelImplCopyWithImpl(_$DestinationListModelImpl _value,
      $Res Function(_$DestinationListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destination = null,
    Object? isTracking = null,
  }) {
    return _then(_$DestinationListModelImpl(
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      isTracking: null == isTracking
          ? _value.isTracking
          : isTracking // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DestinationListModelImpl implements _DestinationListModel {
  const _$DestinationListModelImpl(
      {required this.destination, required this.isTracking});

  factory _$DestinationListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DestinationListModelImplFromJson(json);

  @override
  final String destination;
  @override
  final bool isTracking;

  @override
  String toString() {
    return 'DestinationListModel(destination: $destination, isTracking: $isTracking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DestinationListModelImpl &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.isTracking, isTracking) ||
                other.isTracking == isTracking));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, destination, isTracking);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DestinationListModelImplCopyWith<_$DestinationListModelImpl>
      get copyWith =>
          __$$DestinationListModelImplCopyWithImpl<_$DestinationListModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DestinationListModelImplToJson(
      this,
    );
  }
}

abstract class _DestinationListModel implements DestinationListModel {
  const factory _DestinationListModel(
      {required final String destination,
      required final bool isTracking}) = _$DestinationListModelImpl;

  factory _DestinationListModel.fromJson(Map<String, dynamic> json) =
      _$DestinationListModelImpl.fromJson;

  @override
  String get destination;
  @override
  bool get isTracking;
  @override
  @JsonKey(ignore: true)
  _$$DestinationListModelImplCopyWith<_$DestinationListModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
