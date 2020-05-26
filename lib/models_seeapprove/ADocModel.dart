import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class ADocModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String createdBy;
  final String docType;  
  // final List<WorkFlows> listWorkFlows;
  // final Department department;

  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  const ADocModel({
    this.id ='',
    this.name='',
    this.description='',
    this.imageUrl='',
    this.createdBy='',
    this.docType='',
    // this.listWorkFlows,
    // this.department,

  }) : assert(id != null, name != null);

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => 
  {
        'id': id,
        'name': name??'',
        'description': description??'',
        'imageUrl': imageUrl??'',
        'createdBy': createdBy??'',
        'docType': docType??'',        
        // 'listWorkFlows': listWorkFlows ,
        // 'department': department.toFileStone(),
      };

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory ADocModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return ADocModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',   
      createdBy: data['createdBy'] ?? '',   
      docType: data['docType'] ?? '',         
      // listWorkFlows: data['WorkFlows'],
      // department: Department.fromFilestore(data['department']),
  
    );
  }
}


//=============================================================
// CLASS WORKFLOW
//=============================================================
class WorkFlows {
  //=============================================================
  // 1) VARIABLE
  //============================================================= 
  final String userName;
  final String action;  
  final String comment;  
  //=============================================================
  // 2) CONSTRUCTURE
  //=============================================================  
  WorkFlows({
    this.userName='',
    this.action='', 
    this.comment=''});
  //=============================================================
  // FIRESTONE -> CLASS
  //=============================================================
  factory WorkFlows.fromFilestore(Map<dynamic, dynamic> data) {
    // Map data = doc.data;
    return WorkFlows(
      userName: data['userName'] ?? '',
      action: data['action'] ?? '',
       comment: data['comment'] ?? '',     
    );
  }
  //=============================================================
  // 2) CLASS -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'userName': userName,
        'action': action,
        'comment': comment,
      };


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
