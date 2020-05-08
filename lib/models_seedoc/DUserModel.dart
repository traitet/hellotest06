import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class DUserModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String email;
  final String empid;
  final String firstname;
  final String lastname;
  final String lineid;
  final String mobileno;
  final String companyName;
  final String companyTaxid;
  final Department department;
  // final Address address;
  // final List<Map<String, dynamic>> staff;

  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  DUserModel({
    this.email,
    this.empid,
    this.firstname,
    this.lastname,
    this.lineid,
    this.mobileno,
    this.companyName,
    this.companyTaxid,
    this.department,
    // this.address,
    // this.staff,
  });

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'email': email,
        'empid': empid,
        'firstname': firstname,
        'lastname': lastname,
        'lineid': lineid,
        'mobileno': mobileno,
        'company_taxid': companyTaxid,
        'company_name': companyName,
        'department': department.toFileStone(),
        // 'address': address.toFileStone(),
        // 'staff': staff,
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
      department: Department.fromFilestore(data['department']),
      // address: Address.fromFilestore(data['address']),      
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
      department: json['department'],
      // address : json['address'],
      // staff: json['staff'],
    );
  }
}

//===============================================================
// CLASS USER DETAIL
//===============================================================
class Department {
  final String deptId;
  final String deptName;

  //=============================================================
  // CONSTUCTURE
  //=============================================================
  Department({this.deptId, this.deptName});

  //=============================================================
  // FIRESTONE -> CLASS
  //=============================================================
  factory Department.fromFilestore(Map<dynamic, dynamic> data) {
    // Map data = doc.data;
    return Department(
      deptId: data['deptid'] ?? '',
      deptName: data['deptname'] ?? '',
    );
  }

  //=============================================================
  // 2) CLASS -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'deptid': deptId,
        'deptname': deptName,
      };
}

class Address {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String street;
  final String city;
  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  Address({this.street, this.city});

  //=============================================================
  // 1) FOR GET DATA
  //=============================================================
  factory Address.fromFilestore(Map<dynamic, dynamic> data) {
    return Address(street: data['street'], city: data['city']);
  }

  //=============================================================
  // 2) FOR INSERT DATA
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'street': street,
        'city': city,
      };
}
