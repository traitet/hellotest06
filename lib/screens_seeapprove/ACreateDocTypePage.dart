import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/models_seeapprove/ADocTypeModel.dart';
import 'package:hellotest06/services/LoggerService.dart';
import 'package:hellotest06/services/ShowNotification.dart';

class ACreateDocTypePage extends StatefulWidget {
   //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  ACreateDocTypePage({Key key, @required this.email,}): super(key: key);  
  @override
  _ACreateDocTypePageState createState() => _ACreateDocTypePageState();
}

class _ACreateDocTypePageState extends State<ACreateDocTypePage> {
//======================================================================
// DECLARE TEXT EDIT CONTROLLER
//====================================================================== 
      //final _createdByController = TextEditingController()..text;
      final _idController = TextEditingController()..text = 'CAR';
      final _nameController = TextEditingController()..text = 'CAR';
      final _descriptionController = TextEditingController()..text = 'CAR';    
      final _imageUrl = TextEditingController()..text = 'https://firebasestorage.googleapis.com/v0/b/hellotest06-88fae.appspot.com/o/download.png?alt=media&token=7193690e-bd2b-4880-b949-8267024beed6';          
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Maintain Doc Type'),),
      body: ListView(children: <Widget>[
//======================================================================
// TEXT INPUT
//======================================================================         
            TextFormField(decoration: InputDecoration(labelText: '*Id:', prefixIcon: Icon(Icons.near_me)),controller: _idController,),
            TextFormField(decoration: InputDecoration(labelText: '*Name:', prefixIcon: Icon(Icons.people_outline)),controller: _nameController),        
            TextFormField(decoration: InputDecoration(labelText: '*Description', prefixIcon: Icon(Icons.people)),controller: _descriptionController),
            TextFormField(decoration: InputDecoration(labelText: '*imageURL', prefixIcon: Icon(Icons.people)),controller: _imageUrl),                                                   
//======================================================================
// SAVE INPUT
//======================================================================             
            RaisedButton(onPressed: (){
//======================================================================
// SAVE TO DB
//======================================================================               
              ADocTypeModel myModel = ADocTypeModel(id: _idController.text,name: _nameController.text,description: _descriptionController.text);
              logger.i(myModel.toFileStone());
              String _timestampstr = DateTime.now().millisecondsSinceEpoch.toString(); 
              Firestore.instance.collection('ATT_DOC_TYPE').document(_timestampstr).setData(myModel.toFileStone());
//======================================================================
// SAVE COMPLETE
//======================================================================               
              setState(() {
                logger.i('Insert DOCTYPE Completed');
                showMessageBox(context, "success", "Register Document Type($_timestampstr) to Firestore Database completely", actions: [dismissButton(context)]);
              });

//======================================================================
// BUTTON TEXT
//====================================================================== 
             }, child: Text('Save New Doc Type'),),    






      ],),
      
    );
  }
}