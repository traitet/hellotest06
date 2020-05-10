  //========================================================
  // IMPORT
  //========================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models_seerest/ROrderModel.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';

//==========================================================
// MAIN CLASS
//==========================================================  
class ROrderNewPage extends StatefulWidget {
  @override
  _ROrderNewPageState createState() => _ROrderNewPageState();
}

//==========================================================
// STATE CLASS
//==========================================================  
class _ROrderNewPageState extends State<ROrderNewPage> {
  //========================================================
  // DECALRE VARIABLE
  //========================================================  
  final _idController = TextEditingController()..text = 'O0001';
  final _nameController = TextEditingController()..text = 'New Order';
  final _descriptionController = TextEditingController()..text = 'New Order (VIP)';
  final _tableController = TextEditingController()..text = 'T0001'; 
  final _customerController = TextEditingController()..text = 'Mr.Traitet'; 
  final _menuIdController = TextEditingController()..text = 'M0001';       
  //final _qtyUrlController = TextEditingController()..text = 'www.image.com';   

  //========================================================
  // OVERRIDE (IMPLEMENT UI)
  //========================================================  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant Order'),),
      body: ListView(
        children: <Widget>[
          //================================================
          // UI: TEXT
          //================================================  
          TextFormField(decoration: InputDecoration(labelText: 'Order ID', prefixIcon: Icon(Icons.insert_chart)),controller: _idController,),
          TextFormField(decoration: InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.insert_chart)),controller: _nameController,),
          TextFormField(decoration: InputDecoration(labelText: 'Description', prefixIcon: Icon(Icons.insert_chart)),controller: _descriptionController,),
          TextFormField(decoration: InputDecoration(labelText: 'Menu ID', prefixIcon: Icon(Icons.insert_chart)),controller:_tableController,), 
          TextFormField(decoration: InputDecoration(labelText: 'Customer', prefixIcon: Icon(Icons.insert_chart)),controller:_customerController,), 
          TextFormField(decoration: InputDecoration(labelText: 'table', prefixIcon: Icon(Icons.insert_chart)),controller:_menuIdController,),                     
          //================================================
          // UI: SAVE BUTTON
          //================================================                      
          RaisedButton(onPressed: (){fnSave();}, child: Text('SAVE'),),               
        ],
      ),
    );
  }

  //========================================================
  // SAVE (COLLECTION=TABLE, DOCUMENT=PK)
  //========================================================   
  fnSave() {
  //========================================================
  // PREPARE DATA
  //========================================================       
    ROrderModel myModel = ROrderModel(
      id: _idController.text,
      name: _nameController.text, 
      description: _descriptionController.text, 
      menuId: _menuIdController.text,
      customer: _customerController.text,
      qty: 1,
      table: _tableController.text,                  
    );
  //========================================================
  // SHOW LOG
  //========================================================   
    logger.i(myModel.toFileStone());
   //=======================================================
  // SAVE DB TO FIRESTORE
  //========================================================     
    Firestore.instance.collection("TT_REST_ORDER").document(_idController.text).setData(myModel.toFileStone())        // SAVE DB
    .then((returnDocuments){        // IF COMPLETE
      logger.i('Insert Complete');  // PRINT LOG
      showMessageBox(context, "Success", _idController.text + " saved completely", actions: [dismissButton(context)]);   //POP UP COMPLETE
    }
    ).catchError((e){               // IF ERROR
        logger.e("Insert Error");   // PRINT LOG
    });

    logger.i('test');
    
  }


}