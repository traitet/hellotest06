import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class ADocTypeModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  // final String docId;  
  final String id;
  final String name;
  final String description;
  final String imageUrl;


  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  ADocTypeModel({
    // this.docId,
    this.id,
    this.name,
    this.description,
    this.imageUrl,    
  });

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        // 'docId': docId,
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,        
      };

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory ADocTypeModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return ADocTypeModel(
      // docId: data['docId'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',   
      imageUrl: data['imageUrl'] ?? '',        
   
    );
  }

}