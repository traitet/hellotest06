import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class DUserModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
    String email;
    String empid;
    String firstname;
    String lastname;
    String lineid;
    String mobileno;
    String companyName;
    String companyTaxid;

  //=============================================================
  // 2) GET/SET
  //=============================================================
  DUserModel(
      {this.email,
      this.empid,
      this.firstname,
      this.lastname,
      this.lineid,
      this.mobileno,
      this.companyName,
      this.companyTaxid});

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() =>
    {
      'email': email,
      'empid': empid,      
      'firstname': firstname,
      'lastname': lastname,  
      'lineid': lineid,   
      'mobileno': mobileno,   
      'company_taxid': companyTaxid, 
      'company_name': companyName,                                   
    };

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory DUserModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return DUserModel(
      email: data['email'] ?? '',
      empid: data['empid'] ?? '',      
      firstname: data['firstname'] ?? '',
      lastname: data['lastname'] ?? '',
      lineid: data['lineid'] ?? '',
      mobileno: data['mobileno'],
      companyTaxid: data['company_taxid'],
      companyName: data['company_name'],
    );
  }

  //=============================================================
  // MAP JSON -> MODEL
  //=============================================================
  factory DUserModel.fromJson(Map<String, dynamic> json) {
    return DUserModel(
      email: json['email'] ?? '',
      empid: json['empid'] ?? '',      
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      lineid: json['lineid'] ?? '',
      mobileno: json['mobileno'],
      companyTaxid: json['company_taxid'],
      companyName: json['company_name'],
    );
  }
}




