import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class DUserModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String email;
  final String firstname;
  final String lastname;
  final String lineid;
  final String mobileno;
  final String companyName;
  final String companyTaxid;

  //=============================================================
  // 2) GET/SET
  //=============================================================
  DUserModel(
      {this.email,
      this.firstname,
      this.lastname,
      this.lineid,
      this.mobileno,
      this.companyName,
      this.companyTaxid});

  //=============================================================
  // FACTORY: MAP DATA TO FIRESTORE
  //=============================================================
  factory DUserModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return DUserModel(
        email: data['email'] ?? '',
        firstname: data['firstname'] ?? '',
        lastname: data['lastname'] ?? '',
        lineid: data['lineid'] ?? '',
        mobileno: data['mobileno'],
        companyTaxid: data['company_taxid'],
        companyName: data['company_name'],);
  }

  //=============================================================
  // FACTORY: MAP DATA TO JSON
  //=============================================================
  factory DUserModel.fromJson(Map<String, dynamic> json) {
    return DUserModel(
        email: json['email'] ?? '',
        firstname: json['firstname'] ?? '',
        lastname: json['lastname'] ?? '',
        lineid: json['lineid'] ?? '',
        mobileno: json['mobileno'],
        companyTaxid: json['company_taxid'],
        companyName: json['company_name'],
      );
    
  }
}

