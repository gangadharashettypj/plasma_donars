import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel {
  String fullName;
  String area;
  String address;
  int pinCode;
  int phoneNumber;
  String bloodGroup;
  int numberOfDays;
  int aadharNumber;

  RegisterModel({
    this.fullName,
    this.area,
    this.address,
    this.pinCode,
    this.phoneNumber,
    this.bloodGroup,
    this.numberOfDays,
    this.aadharNumber,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
