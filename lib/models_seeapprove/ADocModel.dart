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
  //final DateTime createdTime;
  // final int spicy;
  // final int rating;

  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  ADocModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.createdBy,
    this.docType,
    // this.rating

  });

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'createdBy': createdBy,
        'docType': docType,        
        // 'rating': rating
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
      // rating: data['rating'] ?? 0,     
    );
  }

}