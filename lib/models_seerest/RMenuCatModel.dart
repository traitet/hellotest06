import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class RMenuCatModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  RMenuCatModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl

  });

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
      };

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory RMenuCatModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return RMenuCatModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
     imageUrl: data['imageUrl'] ?? 0,     
    );
  }

}