import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class RMenuModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String menuId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  RMenuModel({
    this.menuId,
    this.name,
    this.description,
    this.price,
    this.imageUrl

  });

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'menuId': menuId,
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      };

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory RMenuModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return RMenuModel(
      menuId: data['menuId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0,
      imageUrl: data['imageUrl'] ?? 0,     
    );
  }

}