  //========================================================
  // IMPORT
  //========================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models_seerest/RMenuCatModel.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';

//==========================================================
// MAIN CLASS
//==========================================================  
class RMenuCatNewPage extends StatefulWidget {
  @override
  _RMenuCatNewPageState createState() => _RMenuCatNewPageState();
}

//==========================================================
// STATE CLASS
//==========================================================  
class _RMenuCatNewPageState extends State<RMenuCatNewPage> {
  //========================================================
  // DECALRE VARIABLE
  //========================================================  
  final _idController = TextEditingController()..text = 'C0001';
  final _nameController = TextEditingController()..text = 'Drinks';
  final _descriptionController = TextEditingController()..text = 'Drinks and others';
  final _imageUrlController = TextEditingController()..text = 'www.image.com';   

  //========================================================
  // OVERRIDE (IMPLEMENT UI)
  //========================================================  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register New Menu Category'),),
      body: ListView(
        children: <Widget>[
          //================================================
          // UI: TEXT
          //================================================  
          TextFormField(decoration: InputDecoration(labelText: 'Menu ID', prefixIcon: Icon(Icons.insert_chart)),controller: _idController,),
          TextFormField(decoration: InputDecoration(labelText: 'Menu Name', prefixIcon: Icon(Icons.insert_chart)),controller: _nameController,),
          TextFormField(decoration: InputDecoration(labelText: 'Menu Description', prefixIcon: Icon(Icons.insert_chart)),controller: _descriptionController,),
          TextFormField(decoration: InputDecoration(labelText: 'Menu Image URL', prefixIcon: Icon(Icons.insert_chart)),controller:_imageUrlController,), 
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
    RMenuCatModel myModel = RMenuCatModel(
      id: _idController.text,
      name: _nameController.text, 
      description: _descriptionController.text, 
      imageUrl: _imageUrlController.text
    );
  //========================================================
  // SHOW LOG
  //========================================================   
    logger.i(myModel.toFileStone());
   //=======================================================
  // SAVE DB TO FIRESTORE
  //========================================================     
    Firestore.instance.collection("TM_REST_MENU_CAT").document(_idController.text).setData(myModel.toFileStone())        // SAVE DB
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