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
  List<Metro> get wholeMetros => throw _privateConstructorUsedError;
  List<Metro> get sortedMetroByLine => throw _privateConstructorUsedError;
  String get selectedStation => throw _privateConstructorUsedError;
  List<Metro> get destinations => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isOtherTracking => throw _privateConstructorUsedError;

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
      List<Metro> wholeMetros,
      List<Metro> sortedMetroByLine,
      String selectedStation,
      List<Metro> destinations,
      bool isLoading,
      bool isOtherTracking});
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
    Object? wholeMetros = null,
    Object? sortedMetroByLine = null,
    Object? selectedStation = null,
    Object? destinations = null,
    Object? isLoading = null,
    Object? isOtherTracking = null,
  }) {
    return _then(_value.copyWith(
      lineNames: null == lineNames
          ? _value.lineNames
          : lineNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wholeMetros: null == wholeMetros
          ? _value.wholeMetros
          : wholeMetros // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      sortedMetroByLine: null == sortedMetroByLine
          ? _value.sortedMetroByLine
          : sortedMetroByLine // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      selectedStation: null == selectedStation
          ? _value.selectedStation
          : selectedStation // ignore: cast_nullable_to_non_nullable
              as String,
      destinations: null == destinations
          ? _value.destinations
          : destinations // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isOtherTracking: null == isOtherTracking
          ? _value.isOtherTracking
          : isOtherTracking // ignore: cast_nullable_to_non_nullable
              as bool,
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
      List<Metro> wholeMetros,
      List<Metro> sortedMetroByLine,
      String selectedStation,
      List<Metro> destinations,
      bool isLoading,
      bool isOtherTracking});
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
    Object? wholeMetros = null,
    Object? sortedMetroByLine = null,
    Object? selectedStation = null,
    Object? destinations = null,
    Object? isLoading = null,
    Object? isOtherTracking = null,
  }) {
    return _then(_$CapitalAreaModelImpl(
      lineNames: null == lineNames
          ? _value._lineNames
          : lineNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      wholeMetros: null == wholeMetros
          ? _value._wholeMetros
          : wholeMetros // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      sortedMetroByLine: null == sortedMetroByLine
          ? _value._sortedMetroByLine
          : sortedMetroByLine // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      selectedStation: null == selectedStation
          ? _value.selectedStation
          : selectedStation // ignore: cast_nullable_to_non_nullable
              as String,
      destinations: null == destinations
          ? _value._destinations
          : destinations // ignore: cast_nullable_to_non_nullable
              as List<Metro>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isOtherTracking: null == isOtherTracking
          ? _value.isOtherTracking
          : isOtherTracking // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CapitalAreaModelImpl implements _CapitalAreaModel {
  const _$CapitalAreaModelImpl(
      {final List<String> lineNames = const [],
      final List<Metro> wholeMetros = const [],
      final List<Metro> sortedMetroByLine = const [],
      this.selectedStation = '',
      final List<Metro> destinations = const [],
      this.isLoading = false,
      this.isOtherTracking = false})
      : _lineNames = lineNames,
        _wholeMetros = wholeMetros,
        _sortedMetroByLine = sortedMetroByLine,
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

  final List<Metro> _wholeMetros;
  @override
  @JsonKey()
  List<Metro> get wholeMetros {
    if (_wholeMetros is EqualUnmodifiableListView) return _wholeMetros;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wholeMetros);
  }

  final List<Metro> _sortedMetroByLine;
  @override
  @JsonKey()
  List<Metro> get sortedMetroByLine {
    if (_sortedMetroByLine is EqualUnmodifiableListView)
      return _sortedMetroByLine;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sortedMetroByLine);
  }

  @override
  @JsonKey()
  final String selectedStation;
  final List<Metro> _destinations;
  @override
  @JsonKey()
  List<Metro> get destinations {
    if (_destinations is EqualUnmodifiableListView) return _destinations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_destinations);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isOtherTracking;

  @override
  String toString() {
    return 'CapitalAreaModel(lineNames: $lineNames, wholeMetros: $wholeMetros, sortedMetroByLine: $sortedMetroByLine, selectedStation: $selectedStation, destinations: $destinations, isLoading: $isLoading, isOtherTracking: $isOtherTracking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapitalAreaModelImpl &&
            const DeepCollectionEquality()
                .equals(other._lineNames, _lineNames) &&
            const DeepCollectionEquality()
                .equals(other._wholeMetros, _wholeMetros) &&
            const DeepCollectionEquality()
                .equals(other._sortedMetroByLine, _sortedMetroByLine) &&
            (identical(other.selectedStation, selectedStation) ||
                other.selectedStation == selectedStation) &&
            const DeepCollectionEquality()
                .equals(other._destinations, _destinations) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isOtherTracking, isOtherTracking) ||
                other.isOtherTracking == isOtherTracking));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_lineNames),
      const DeepCollectionEquality().hash(_wholeMetros),
      const DeepCollectionEquality().hash(_sortedMetroByLine),
      selectedStation,
      const DeepCollectionEquality().hash(_destinations),
      isLoading,
      isOtherTracking);

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
      final List<Metro> wholeMetros,
      final List<Metro> sortedMetroByLine,
      final String selectedStation,
      final List<Metro> destinations,
      final bool isLoading,
      final bool isOtherTracking}) = _$CapitalAreaModelImpl;

  factory _CapitalAreaModel.fromJson(Map<String, dynamic> json) =
      _$CapitalAreaModelImpl.fromJson;

  @override
  List<String> get lineNames;
  @override
  List<Metro> get wholeMetros;
  @override
  List<Metro> get sortedMetroByLine;
  @override
  String get selectedStation;
  @override
  List<Metro> get destinations;
  @override
  bool get isLoading;
  @override
  bool get isOtherTracking;
  @override
  @JsonKey(ignore: true)
  _$$CapitalAreaModelImplCopyWith<_$CapitalAreaModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
