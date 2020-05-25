import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models_seelastminute/LDealModel.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
import 'package:path/path.dart' as Path;

class LCreateDealPage extends StatefulWidget {
   //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;

  LCreateDealPage({Key key, @required this.email}): super(key: key);  
  @override
  _LCreateDealPageState createState() => _LCreateDealPageState();
}

class _LCreateDealPageState extends State<LCreateDealPage> {
//======================================================================
// DECLARE TEXT EDIT CONTROLLER
//====================================================================== 
      //final _createdByController = TextEditingController()..text;
      final _nameController = TextEditingController()..text = 'Create Last Minute Deal';
      final _descriptionController = TextEditingController()..text = 'Document on 18 May 2020'; 
      final String _timestampstr = DateTime.now().millisecondsSinceEpoch.toString();    
      //====================================================================================
      // 1) DECLARE VARIABLE FOR UPLOAD IMAGE
      //====================================================================================
      File _image;
      String _uploadedFileURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Doc: ' + _timestampstr),),
      body: ListView(children: <Widget>[


//======================================================================
// TEXT INPUT
//======================================================================         
            TextFormField(decoration: InputDecoration(labelText: '*Name', prefixIcon: Icon(Icons.near_me)),controller: _nameController,),
            TextFormField(decoration: InputDecoration(labelText: '*Description', prefixIcon: Icon(Icons.vpn_key)),controller: _descriptionController),                         
//======================================================================
// SAVE INPUT
//======================================================================             
            RaisedButton(onPressed: () async {
//======================================================================
// SAVE INPUT
//======================================================================
              await fnUploadFile();  
              logger.i('upload image completed: ' + _uploadedFileURL??''  );          
//======================================================================
// SAVE TO DB
//======================================================================               
              LDealModel myModel = LDealModel(docType: "DEAL",name: _nameController.text,description: _descriptionController.text, createdBy: widget.email,imageUrl: _uploadedFileURL);
              logger.i(myModel.toFileStone());
              Firestore.instance.collection('LTT_DEAL').document(_timestampstr).setData(myModel.toFileStone());
//======================================================================
// SAVE COMPLETE
//======================================================================               
              setState(() {
                logger.i('Insert Order Completed');
                showMessageBox(context, "success", "Register Document($_timestampstr) to Firestore Database completely", actions: [dismissButton(context)]);
              });

//======================================================================
// BUTTON TEXT
//====================================================================== 
             }, child: Text('Save New Document'),),       
             
//======================================================================
// SELECT IMAGE BUTTON
//====================================================================== 
          RaisedButton(child: Text("Select Image"), onPressed: chooseFile),
//======================================================================
// SHOW IMAGE
//====================================================================== 
         _image != null ? Image.asset(_image.path,height: 200,): Center(child: Text('Click above botton to select image')),

      ],),
      
    );
  }

//**************************************************************************************************************************/
// WIDGET
//**************************************************************************************************************************/

//======================================================
// WIDGET:IMAGE BODY WIDGET
//======================================================
Widget widgetBodyImage() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/images/bg01.jpg',
          width: 300, height: 200, fit: BoxFit.cover),
    );


//====================================================================================
// FUNCTION: CHOOSE FILE
//====================================================================================
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {setState(() {_image = image;});
  });
  }

//====================================================================================
// FUNCTION#2: UPLOAD
//====================================================================================
  Future fnUploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    logger.i('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }


}