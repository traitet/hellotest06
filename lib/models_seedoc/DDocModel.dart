import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class DDocModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String id;
  final String username;
  final String title;
  final String imageUrl;
  Map<UserDetail, dynamic> userDetailModel;
  final List<WorkFlows> workflows;
  final Timestamp createTime;

  //=============================================================
  // 2) GET/SET
  //=============================================================
  DDocModel(
      {this.id,
      this.username,
      this.title,
      this.imageUrl,
      this.createTime,
      this.userDetailModel,
      this.workflows});

  //=============================================================
  // FACTORY: MAP DATA TO FIRESTORE
  //=============================================================
  factory DDocModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return DDocModel(
        id: data['id'] ?? '',
        username: data['username'] ?? '',
        title: data['title'] ?? '',
        imageUrl: data['image_url'] ?? '',
        createTime: data['create_time'],
        userDetailModel: new Map<UserDetail, dynamic>(),
        workflows: new List<WorkFlows>());
  }

  //=============================================================
  // FACTORY: MAP DATA TO JSON
  //=============================================================
  factory DDocModel.fromJson(Map<String, dynamic> json) {
    return DDocModel(
      id: json['id'],
      username: json['username'],
      title: json['title'],
      createTime: json['create_time'],
      imageUrl: json['image_url'],
    );
  }
}

//===============================================================
// CLASS USER DETAIL
//===============================================================
class UserDetail {
  final String fullname;
  final String mobileNo;
  final String deptId;
  final String deptName;

  UserDetail({this.fullname, this.mobileNo, this.deptId, this.deptName});

  //=============================================================
  // FACTORY: MAP DATA TO FIRESTORE
  //=============================================================
  factory UserDetail.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return UserDetail(
      fullname: data['fullname'] ?? '',
      mobileNo: data['mobileno'] ?? '',
      deptId: data['deptid'] ?? '',
      deptName: data['deptname'],
    );
  }
}

//===============================================================
// CLASS WORKFLOW
//===============================================================
class WorkFlows {
  final String user;
  final String action;

  WorkFlows({
    this.user,
    this.action,
  });

  //=============================================================
  // FACTORY: MAP DATA TO FIRESTORE
  //=============================================================
  factory WorkFlows.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return WorkFlows(
      user: data['user'] ?? '',
      action: data['action'] ?? '',
    );
  }
}
