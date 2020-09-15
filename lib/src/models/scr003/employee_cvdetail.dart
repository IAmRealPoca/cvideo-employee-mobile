import 'package:equatable/equatable.dart';

class EmployeeDetail extends Equatable {
  final String accountId;
  final String fullname;
  final String gender;
  final String phone;
  final String email;
  final String address;
  final String avatar;
  final String dateOfBirth;
  final int numOfCVs;
  final int numOfVideos;

  EmployeeDetail({
    this.accountId,
    this.address,
    this.avatar,
    this.dateOfBirth,
    this.email,
    this.fullname,
    this.gender,
    this.numOfCVs,
    this.numOfVideos,
    this.phone,
  });

  @override
  List<Object> get props => [];

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) {
    //map session to list
    //map employee
    return EmployeeDetail(
      accountId: json['accountId'] == null ? "" : json['accountId'].toString(),
      dateOfBirth:
          json['dateOfBirth'] == null ? "" : json['dateOfBirth'].toString(),
      gender: json['gender'] == null ? "" : json['gender'].toString(),
      phone: json['phone'] == null ? "" : json['phone'].toString(),
      email: json['email'] == null ? "" : json['email'].toString(),
      address: json['address'] == null ? "" : json['address'].toString(),
      avatar: json['avatar'] == null ? "" : json['avatar'].toString(),
      fullname: json['fullName'] == null ? "" : json['fullName'].toString(),
      numOfCVs: json['numOfCVs'] == null ? 0 : json['numOfCVs'],
      numOfVideos: json['numOfVideos'] == null ? 0 : json['numOfVideos'],
    );
  }
}
