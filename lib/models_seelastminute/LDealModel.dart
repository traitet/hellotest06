import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class LDealModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  String id;
  String name;
  String description;
  String imageUrl;
  String createdBy;
  String docType;  
  List<String> streets;
  List<WorkFlows> workflows;
  // final WorkFlows workFlows;

  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  LDealModel({
    this.id  = Uuid.NAMESPACE_X500,
    this.name='',
    this.description='',
    this.imageUrl='',
    this.createdBy='',
    this.docType='',
    this.streets,
    this.workflows,
    // this.workFlows,

  }) : assert(id != null, name != null);

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone()  {
    return {
        'id': id,
        'name': name??'',
        'description': description??'',
        'imageUrl': imageUrl??'',
        'createdBy': createdBy??'',
        'docType': docType??'',  
        'workflows': workflows.map((e) => e.userName).toList() , 
        'streets': streets,
        // 'workFlows': workflows,
    };
  }

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory LDealModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return LDealModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',   
      createdBy: data['createdBy'] ?? '',   
      docType: data['docType'] ?? '',     
      streets: data['streets'],
      workflows: data['workflows']    
      //workFlows: WorkFlows.fromFilestore(data['workFlows']),
  
    );
  }
}





// class WorkFlowsList {
//   final List<WorkFlows> workflows;
//   WorkFlowsList({
//     this.workflows
//   });


//   Map<String, dynamic> toFileStone() => {
//         'workflows': workflows,
//       };



//   factory WorkFlowsList.fromFirestone(List<WorkFlows> doc) {

//     List<WorkFlows> workflows = new List<WorkFlows>();

//     return new WorkFlowsList(
//        workflows: workflows,
//     );
//   }
// }








//=============================================================
// CLASS WORKFLOW
//=============================================================
class WorkFlows {
  //=============================================================
  // 1) VARIABLE
  //============================================================= 
  String userName;
  String action;  
  String comment;  
  //=============================================================
  // 2) CONSTRUCTURE
  //=============================================================  
  WorkFlows({
    this.userName,
    this.action, 
    this.comment
    });
  //=============================================================
  // FIRESTONE -> CLASS
  //=============================================================
  factory WorkFlows.fromFilestore(Map<String, dynamic> data) {
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
class Department1 {
  final String deptId;
  final String deptName;

  //=============================================================
  // CONSTUCTURE
  //=============================================================
  Department1({this.deptId, this.deptName});

  //=============================================================
  // FIRESTONE -> CLASS
  //=============================================================
  factory Department1.fromFilestore(Map<dynamic, dynamic> data) {
    // Map data = doc.data;
    return Department1(
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
