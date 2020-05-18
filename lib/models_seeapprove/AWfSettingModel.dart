import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class AWfSettingModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String docId;  
  final String approve1;
  final String approve2;
  final String approve3;


  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  AWfSettingModel({
    this.docId,
    this.approve1,
    this.approve2,
    this.approve3,
  });

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'docId': docId,
        'approve1': approve1,
        'approve2': approve2,
        'approve3': approve3,
      };

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory AWfSettingModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return AWfSettingModel(
      docId: data['docId'] ?? '',
      approve1: data['approve1'] ?? '',
      approve2: data['approve2'] ?? '',
      approve3: data['approve3'] ?? '',   
   
    );
  }

}