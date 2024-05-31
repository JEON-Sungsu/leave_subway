// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capital_area_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CapitalAreaModel _$CapitalAreaModelFromJson(Map<String, dynamic> json) {
  return _CapitalAreaModel.fromJson(json);
}

/// @nodoc
mixin _$CapitalAreaModel {
  List<String> get lineNames => throw _privateConstructorUsedError;
  List<Metro> get metros => throw _privateConstructorUsedError;
  List<Metro> get selectedMetros => throw _privateConstructorUsedError;
  String get currentStation => throw _privateConstructorUsedError;
  List<Metro> get destinations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CapitalAreaModelCopyWith<CapitalAreaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapitalAreaModelCopyWith<$Res> {
  factory $CapitalAreaModelCopyWith(
          CapitalAreaModel value, $Res Function(CapitalAreaModel) then) =
      _$CapitalAreaModelCopyWithImpl<$Res, CapitalAreaModel>;
  @useResult
  $Res call(
      {List<String> lineNames,
      List<Metro> metros,
      List<Metro> selectedMetros,
      String currentStation,
      List<Metro> destinations});
}

/// @nodoc
class _$CapitalAreaModelCopyWithImpl<$Res, $Val extends CapitalAreaModel>
    implements $CapitalAreaModelCopyWith<$Res> {
  _$CapitalAreaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lineNames = null,
    Object? metros = null,
    Object? selectedMetros = null,
    Object? currentStation = null,
    Object? destinations = null,
  }) {
    return _then(_value.copyWith(
      lineNames: null == lineNames
          ? _value.lineNames
          : lineNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metros: null == metros
          ? _value.metros
          : metros // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      selectedMetros: null == selectedMetros
          ? _value.selectedMetros
          : selectedMetros // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      currentStation: null == currentStation
          ? _value.currentStation
          : currentStation // ignore: cast_nullable_to_non_nullable
              as String,
      destinations: null == destinations
          ? _value.destinations
          : destinations // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CapitalAreaModelImplCopyWith<$Res>
    implements $CapitalAreaModelCopyWith<$Res> {
  factory _$$CapitalAreaModelImplCopyWith(_$CapitalAreaModelImpl value,
          $Res Function(_$CapitalAreaModelImpl) then) =
      __$$CapitalAreaModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> lineNames,
      List<Metro> metros,
      List<Metro> selectedMetros,
      String currentStation,
      List<Metro> destinations});
}

/// @nodoc
class __$$CapitalAreaModelImplCopyWithImpl<$Res>
    extends _$CapitalAreaModelCopyWithImpl<$Res, _$CapitalAreaModelImpl>
    implements _$$CapitalAreaModelImplCopyWith<$Res> {
  __$$CapitalAreaModelImplCopyWithImpl(_$CapitalAreaModelImpl _value,
      $Res Function(_$CapitalAreaModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lineNames = null,
    Object? metros = null,
    Object? selectedMetros = null,
    Object? currentStation = null,
    Object? destinations = null,
  }) {
    return _then(_$CapitalAreaModelImpl(
      lineNames: null == lineNames
          ? _value._lineNames
          : lineNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metros: null == metros
          ? _value._metros
          : metros // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      selectedMetros: null == selectedMetros
          ? _value._selectedMetros
          : selectedMetros // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      currentStation: null == currentStation
          ? _value.currentStation
          : currentStation // ignore: cast_nullable_to_non_nullable
              as String,
      destinations: null == destinations
          ? _value._destinations
          : destinations // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CapitalAreaModelImpl implements _CapitalAreaModel {
  const _$CapitalAreaModelImpl(
      {final List<String> lineNames = const [],
      final List<Metro> metros = const [],
      final List<Metro> selectedMetros = const [],
      this.currentStation = '',
      final List<Metro> destinations = const []})
      : _lineNames = lineNames,
        _metros = metros,
        _selectedMetros = selectedMetros,
        _destinations = destinations;

  factory _$CapitalAreaModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CapitalAreaModelImplFromJson(json);

  final List<String> _lineNames;
  @override
  @JsonKey()
  List<String> get lineNames {
    if (_lineNames is EqualUnmodifiableListView) return _lineNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lineNames);
  }

  final List<Metro> _metros;
  @override
  @JsonKey()
  List<Metro> get metros {
    if (_metros is EqualUnmodifiableListView) return _metros;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_metros);
  }

  final List<Metro> _selectedMetros;
  @override
  @JsonKey()
  List<Metro> get selectedMetros {
    if (_selectedMetros is EqualUnmodifiableListView) return _selectedMetros;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedMetros);
  }

  @override
  @JsonKey()
  final String currentStation;
  final List<Metro> _destinations;
  @override
  @JsonKey()
  List<Metro> get destinations {
    if (_destinations is EqualUnmodifiableListView) return _destinations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_destinations);
  }

  @override
  String toString() {
    return 'CapitalAreaModel(lineNames: $lineNames, metros: $metros, selectedMetros: $selectedMetros, currentStation: $currentStation, destinations: $destinations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapitalAreaModelImpl &&
            const DeepCollectionEquality()
                .equals(other._lineNames, _lineNames) &&
            const DeepCollectionEquality().equals(other._metros, _metros) &&
            const DeepCollectionEquality()
                .equals(other._selectedMetros, _selectedMetros) &&
            (identical(other.currentStation, currentStation) ||
                other.currentStation == currentStation) &&
            const DeepCollectionEquality()
                .equals(other._destinations, _destinations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_lineNames),
      const DeepCollectionEquality().hash(_metros),
      const DeepCollectionEquality().hash(_selectedMetros),
      currentStation,
      const DeepCollectionEquality().hash(_destinations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CapitalAreaModelImplCopyWith<_$CapitalAreaModelImpl> get copyWith =>
      __$$CapitalAreaModelImplCopyWithImpl<_$CapitalAreaModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CapitalAreaModelImplToJson(
      this,
    );
  }
}

abstract class _CapitalAreaModel implements CapitalAreaModel {
  const factory _CapitalAreaModel(
      {final List<String> lineNames,
      final List<Metro> metros,
      final List<Metro> selectedMetros,
      final String currentStation,
      final List<Metro> destinations}) = _$CapitalAreaModelImpl;

  factory _CapitalAreaModel.fromJson(Map<String, dynamic> json) =
      _$CapitalAreaModelImpl.fromJson;

  @override
  List<String> get lineNames;
  @override
  List<Metro> get metros;
  @override
  List<Metro> get selectedMetros;
  @override
  String get currentStation;
  @override
  List<Metro> get destinations;
  @override
  @JsonKey(ignore: true)
  _$$CapitalAreaModelImplCopyWith<_$CapitalAreaModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
