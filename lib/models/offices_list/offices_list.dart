import 'package:json_annotation/json_annotation.dart';
import 'package:test_unikoom/models/office/office.dart';

part 'offices_list.g.dart';

@JsonSerializable()
class OfficesList {
  final List<Office> offices;

  const OfficesList({this.offices});

  factory OfficesList.fromJson(Map<String, dynamic> json) =>
      _$OfficesListFromJson(json);

  Map<String, dynamic> toJson() => _$OfficesListToJson(this);
}
