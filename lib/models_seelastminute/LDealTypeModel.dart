import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class LDealTypeModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  List<String> types;


  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  LDealTypeModel({
    this.types,
  }) ;

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory LDealTypeModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return LDealTypeModel(
  
      types: List<String>.from(data['type']), 

    );
  }


  //=============================================================
  // 4) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStore()  {
    return {
 
        'types': types,        

    };
  }

 
}
