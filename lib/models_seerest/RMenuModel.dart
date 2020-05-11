import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class RMenuModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int spicy;
  final int rating;
  final String menuCategory; 

  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  RMenuModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.price,
    this.spicy,
    this.rating,
    this.menuCategory,

  });

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'price': price,
        'spicy': spicy,        
        'rating': rating,
        'menuCategory': menuCategory,
      };

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory RMenuModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return RMenuModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? 0,   
      price: data['price'] ?? 0,   
      spicy: data['spicy'] ?? 0,         
      rating: data['rating'] ?? 0,  
     menuCategory: data['menuCategory'] ?? '',         
    );
  }

}