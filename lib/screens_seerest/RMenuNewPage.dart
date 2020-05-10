//==========================================================
// IMPORT
//==========================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../models_seerest/RMenuModel.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';

//==========================================================
// MAIN CLASS
//==========================================================  
class RMenuNewPage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String docId;
  RMenuNewPage({Key key, this.docId,}): super(key: key);
  @override
  _RMenuNewPageState createState() => _RMenuNewPageState();
}

//==========================================================
// STATE CLASS
//==========================================================  
class _RMenuNewPageState extends State<RMenuNewPage> {
  //========================================================
  // DECALRE VARIABLE
  //========================================================  
  var _image;
  var _docId;
  String _imageURL = '';  
  final _idController = TextEditingController()..text = 'M0001';
  final _nameController = TextEditingController()..text = 'Fried rice';
  final _descriptionController = TextEditingController()..text = 'ข้าวผัด'; 
  final _priceController = TextEditingController()..text = '100';
  final _spicyController = TextEditingController()..text = '2';  
  final _ratingController = TextEditingController()..text = '4';    

  //========================================================
  // OVERRIDE (IMPLEMENT UI)
  //========================================================  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register New Menu'),),
      body: ListView(
        children: <Widget>[
          //================================================
          // UI: TEXT
          //================================================  
          TextFormField(decoration: InputDecoration(labelText: 'Menu ID', prefixIcon: Icon(Icons.insert_chart)),controller: _idController,),
          TextFormField(decoration: InputDecoration(labelText: 'Menu Name', prefixIcon: Icon(Icons.insert_chart)),controller: _nameController,),
          TextFormField(decoration: InputDecoration(labelText: 'Menu Description', prefixIcon: Icon(Icons.insert_chart)),controller: _descriptionController,),
          TextFormField(decoration: InputDecoration(labelText: 'Price', prefixIcon: Icon(Icons.insert_chart)),controller:_priceController,), 
          TextFormField(decoration: InputDecoration(labelText: 'Spicy', prefixIcon: Icon(Icons.insert_chart)),controller:_spicyController,), 
          TextFormField(decoration: InputDecoration(labelText: 'Rating', prefixIcon: Icon(Icons.insert_chart)),controller:_ratingController,),  
          //==============================================================================
          // BUILD WIDGET IMAGE AND TEXT
          //==============================================================================
          //==============================================================================
          // BUILD WIDGET IMAGE AND TEXT (1) UPLOAD 2) GOOGLE 3) WRONG URL
          //==============================================================================
            _image != null ? Image.asset(_image.path,height: 200,): _imageURL != '' ?   
            Container(padding: const EdgeInsets.all(8.0),height: 200,child: Image.network(_imageURL)): 
            widgetBodyImage(), 
          //==============================================================================
          // UPLOAD IMAGE         
          //==============================================================================
          RaisedButton(child: Text("Select Image"), onPressed: chooseFile),                                        
          //==============================================================================
          // UI: SAVE BUTTON
          //==============================================================================                      
          RaisedButton(onPressed: (){fnSave();}, child: Text('SAVE'),),               
        ],
      ),
    );
  }

  //======================================================================================
  // SAVE (COLLECTION=TABLE, DOCUMENT=PK)
  //======================================================================================   
  fnSave() async {
    if (_nameController.text == "" || _descriptionController.text =="" ){
        showMessageBox(context, "Error", "Please enter Name and Descripton", actions: [dismissButton(context)]);
        logger.e("Name or Description cannot be null");              
    } // IF
    //====================================================================================
    // 5) SIGNUP USER
    //====================================================================================             
    else {
      //==================================================================================
      // UPDATE IMAGE
      //================================================================================== 
      await fnUploadFile();
      //==================================================================================
      // UPDATE TO DATABASE
      //================================================================================== 
      if (_imageURL != null){    
        //================================================================================
        // PREPARE DATA
        //================================================================================       
        RMenuModel myModel = RMenuModel(
          id: _idController.text,
          name: _nameController.text, 
          description: _descriptionController.text, 
          imageUrl: _imageURL,
          price: double.parse(_priceController.text),
          spicy: int.parse(_spicyController.text),
          rating: int.parse(_ratingController.text)
        );
        //================================================================================
        // SHOW LOG
        //================================================================================   
        logger.i(myModel.toFileStone());
        //================================================================================
        // SAVE DB TO FIRESTORE
        //================================================================================     
        final collRef = Firestore.instance.collection("TM_REST_MENU");
        var docReference = collRef.document();
        //collRef.document(widget.docId==null?DateTime.now().millisecondsSinceEpoch.toString():widget.docId).setData(myModel.toFileStone())            // SAVE DB
        collRef.document(_idController.text).setData(myModel.toFileStone())            // SAVE DB        
        .then((returnDocuments){        // IF COMPLETE
          _docId = docReference.documentID;
          logger.i(_docId + 'Insert Complete ' );  // PRINT LOG
          showMessageBox(context, "Success", _idController.text + " saved completely", actions: [dismissButton(context)]);   //POP UP COMPLETE
        }
        ).catchError((e){               // IF ERROR
          logger.e("Insert Error");   // PRINT LOG
        });
      } //IF
    } // ELSE
  }

  //======================================================================================
  // FUNCTION: CHOOSE FILE
  //======================================================================================
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {setState(() {_image = image;
    });
  });
  }

  //======================================================================================
  // FUNCTION#2: UPLOAD
  //======================================================================================
  Future fnUploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    logger.i('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _imageURL = fileURL;
      
      });
    });
  }

  //======================================================
  // WIDGET:IMAGE BODY WIDGET
  //======================================================
  Widget widgetBodyImage() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/images/bg01.jpg',
          width: 300, height: 200, fit: BoxFit.cover),
    );



}

