import 'package:cloud_firestore/cloud_firestore.dart';

//===============================================================
// CLASS DOC MODEL
//===============================================================
class ROrderModel {
  //=============================================================
  // 1) PROPERTY
  //=============================================================
  final String id;
  final String name;
  final String description; 
  final String table;
  final String customer;
  final String menuId;
  final int qty;

  //=============================================================
  // 2) CONSTUCTURE
  //=============================================================
  ROrderModel({
    this.id,
    this.name,
    this.description,
    this.table,
    this.customer,
    this.menuId,
    this.qty

  });

  //=============================================================
  // 2) MAP MODEL -> SNAPSHOT
  //=============================================================
  Map<String, dynamic> toFileStone() => {
        'id': id,
        'name': name,
        'description': description,
        'table': table,
        'customer': customer,
        'menuId': menuId,
        'qty': qty,        
      };

  //=============================================================
  // 3) MAP SNAPSHOT -> MODEL
  //=============================================================
  factory ROrderModel.fromFilestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return ROrderModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      table: data['table'] ?? '',     
      customer: data['customer'] ?? '',   
      menuId: data['menuId'] ?? '',  
      qty: data['qty']??0,     
    );
  }

}