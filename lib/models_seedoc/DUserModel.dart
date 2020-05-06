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
    Map<String, dynamic> department;
    Map<String, dynamic> address;
    List<Map<String, dynamic>> staff;

  //=============================================================
  // 2) GET/SET
  //=============================================================
  DUserModel(
      {
      this.email,
      this.empid,
      this.firstname,
      this.lastname,
      this.lineid,
      this.mobileno,
      this.companyName,
      this.companyTaxid,
      this.department,
      this.address,
      this.staff,
      });

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
      // 'department' :department,    
      // 'address' :address,   
      // 'staff': staff,                    
    };

    

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory DUserModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data; //MUST CHANGE VALUE. IF NOT CANNOT FIND ADDRESS, DEPARTMENT AND STAFF, AND ALSO NEED OBJECT IS   Map<String, dynamic>
    return DUserModel(
      email: data['email'] ?? '',
      empid: data['empid'] ?? '',      
      firstname: data['firstname'] ?? '',
      lastname: data['lastname'] ?? '',
      lineid: data['lineid'] ?? '',
      mobileno: data['mobileno'],
      companyTaxid: data['company_taxid'],
      companyName: data['company_name'],
      address: data['address'],
      department: data['department'],      
      staff: data['staff'],            
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
      address : json['address'],
      department: json['department'],  
      staff: json['staff'],          
    );
  }
}



//===============================================================
// CLASS USER DETAIL
//===============================================================
class Department {
  String deptId;
  String deptName;

  //=============================================================
  // GET/PUT
  //=============================================================
  Department({this.deptId, this.deptName});

  //=============================================================
  // FIRESTONE -> CLASS
  //=============================================================
  factory Department.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return Department(
      deptId: data['deptid'] ?? '',
      deptName: data['deptname']??'',
    );
  }

  //=============================================================
  // 2) CLASS -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() =>
    {
      'deptid': deptId,
      'deptname': deptName,                                 
    };



}


class Address {
  String street;
  String city;

  Address({this.street, this.city});

  factory Address.fromFilestore(DocumentSnapshot doc) 
  {
    Map data = doc.data;
    return Address(
        street: data['street'],
        city: data['city']);

  }

}

