// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) {
  return RegisterModel(
    fullName: json['fullName'] as String,
    area: json['area'] as String,
    address: json['address'] as String,
    pinCode: json['pinCode'] as int,
    phoneNumber: json['phoneNumber'] as int,
    bloodGroup: json['bloodGroup'] as String,
    numberOfDays: json['numberOfDays'] as int,
    aadharNumber: json['aadharNumber'] as int,
  );
}

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'area': instance.area,
      'address': instance.address,
      'pinCode': instance.pinCode,
      'phoneNumber': instance.phoneNumber,
      'bloodGroup': instance.bloodGroup,
      'numberOfDays': instance.numberOfDays,
      'aadharNumber': instance.aadharNumber,
    };
