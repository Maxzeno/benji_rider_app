// To parse this JSON data, do
//
//     final agentModel = agentModelFromJson(jsonString);

import 'dart:convert';

import '../../providers/constants.dart';

AgentModel agentModelFromJson(String str) =>
    AgentModel.fromJson(json.decode(str));

String agentModelToJson(AgentModel data) => json.encode(data.toJson());

class AgentModel {
  int id;
  String image;
  double balance;
  String email;
  String code;
  String phone;
  String agentname;
  String firstName;
  String lastName;
  String address;
  String gender;
  String religion;
  String worshipHours;
  String stateOfOrigin;
  String lga;
  String permanentAddress;
  String residentialAddress;
  String nearestBusStop;
  String maritalStatus;
  String nameOfSpouse;
  String phoneNumberOfSpouse;
  String license;
  String token;
  bool isVisibleCash;
  String latitude;
  String longitude;
  String referralCode;

  AgentModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.code,
    required this.agentname,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.gender,
    required this.religion,
    required this.worshipHours,
    required this.stateOfOrigin,
    required this.lga,
    required this.permanentAddress,
    required this.residentialAddress,
    required this.nearestBusStop,
    required this.maritalStatus,
    required this.nameOfSpouse,
    required this.phoneNumberOfSpouse,
    required this.license,
    required this.token,
    required this.image,
    required this.balance,
    required this.isVisibleCash,
    required this.latitude,
    required this.longitude,
    required this.referralCode,
  });
  factory AgentModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return AgentModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? notAvailable,
      phone: json['phone'] ?? '',
      code: json['code'] ?? notAvailable,
      agentname: json['agentname'] ?? notAvailable,
      firstName: json['first_name'] ?? notAvailable,
      lastName: json['last_name'] ?? notAvailable,
      address: json['address'] ?? notAvailable,
      gender: json['gender'] ?? notAvailable,
      religion: json['religion'] ?? notAvailable,
      worshipHours: json['worship_hours'] ?? notAvailable,
      stateOfOrigin: json['stateOfOrigin'] ?? notAvailable,
      lga: json['lga'] ?? notAvailable,
      permanentAddress: json['permanent_address'] ?? notAvailable,
      residentialAddress: json['residential_address'] ?? notAvailable,
      nearestBusStop: json['nearest_bus_stop'] ?? notAvailable,
      maritalStatus: json['marital_status'] ?? notAvailable,
      nameOfSpouse: json['nameOfSpouse'] ?? notAvailable,
      phoneNumberOfSpouse: json['phoneNumberOfSpouse'] ?? notAvailable,
      license: json['license'] ?? notAvailable,
      token: json['token'] ?? '',
      image: json['image'] == null || json['image'] == ""
          ? 'https://img.freepik.com/free-psd/3d-icon-social-media-app_23-2150049569.jpg'
          : json['image'],
      balance: double.parse((json['balance'] ?? 0.0).toString()),
      isVisibleCash: json['isVisibleCash'] ?? true,
      latitude: json['latitude'] ?? notAvailable,
      longitude: json['longitude'] ?? notAvailable,
      referralCode: json['referralCode'] ?? notAvailable,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "code": code,
        "agentname": agentname,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "gender": gender,
        "religion": religion,
        "worship_hours": worshipHours,
        "stateOfOrigin": stateOfOrigin,
        "lga": lga,
        "permanent_address": permanentAddress,
        "residential_address": residentialAddress,
        "nearest_bus_stop": nearestBusStop,
        "marital_status": maritalStatus,
        "nameOfSpouse": nameOfSpouse,
        "phoneNumberOfSpouse": phoneNumberOfSpouse,
        "license": license,
        "token": token,
        "image": image,
        "balance": balance,
        "referralCode": referralCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}
