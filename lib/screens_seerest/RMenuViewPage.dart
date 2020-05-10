  //========================================================
  // IMPORT
  //========================================================  
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models_seerest/RMenuModel.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


  //========================================================
  // MAIN CLASS
  //========================================================  
class RMenuViewPage extends StatefulWidget {
  final String menuId;
  
  RMenuViewPage({Key key, @required this.menuId}): super(key: key);  
  @override
  _RMenuViewPageState createState() => _RMenuViewPageState();
}

  //========================================================
  // STATE CLASS
  //========================================================  
class _RMenuViewPageState extends State<RMenuViewPage> {
  File _image;
  String _uploadedFileURL; 
  //========================================================
  // DECALRE VARIABLE
  //========================================================  
  final _idController = TextEditingController()..text = '';
  final _nameController = TextEditingController()..text = 'Fried rice';
  final _descriptionController = TextEditingController()..text = 'ข้าวผัด';
  final _imageUrlController = TextEditingController()..text = 'www.imagefoodmenu.com';   
  final _priceController = TextEditingController()..text = '100';
  final _spicyController = TextEditingController()..text = '2';  
  final _ratingController = TextEditingController()..text = '4';   

//========================================================================================
// 4) GET DATA FROM DB ?? YES
//========================================================================================
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection("TM_REST_MENU").document(widget.menuId).get().then((value) {
      setState(() {
        _idController.text = value.data["id"];
        _nameController.text = value.data["name"];
        _descriptionController.text = value.data["description"];
        _imageUrlController.text = value.data["imageUrl"];
        _priceController.text = value.data["price"].toString();
        _spicyController.text = value.data["spicy"].toString();  
        _spicyController.text = value.data["rating"].toString();  
                   
      });
    });
  }

  //========================================================
  // OVERRIDE (IMPLEMENT UI)
  //========================================================  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View and Edit Menu'),
      actions: <Widget>[IconButton(icon: Icon(Icons.camera_alt), onPressed: chooseFile),],  ),    
      body: ListView(
        children: <Widget>[
              
          _idController.text == '' ? Text("Loading . . . "):
          //==============================================================================
          // BUILD WIDGET IMAGE AND TEXT
          //==============================================================================
          _imageUrlController.text !='' ? Container(padding: const EdgeInsets.all(8.0),height: 200,child: Image.network(_imageUrlController.text)): widgetBodyImage(),          
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
          // UPLOAD IMAGE         
          //==============================================================================
          RaisedButton(child: Text("Select Image"), onPressed: chooseFile),

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
  fnSave() async {
    await fnUploadFile();
    //========================================================
    // PREPARE DATA
    //========================================================       
    RMenuModel myModel = RMenuModel(
      id: _idController.text,
      name: _nameController.text, 
      description: _descriptionController.text, 
      imageUrl: _uploadedFileURL,
      price: double.parse(_priceController.text),
      spicy: int.parse(_spicyController.text),
      rating: int.parse(_ratingController.text)      
    );
  //========================================================
  // SHOW LOG
  //========================================================   
    logger.i(myModel.toFileStone());
   //=======================================================
  // SAVE DB TO FIRESTORE
  //========================================================     
    Firestore.instance.collection("TM_REST_MENU").document(_idController.text).setData(myModel.toFileStone())        // SAVE DB
    .then((returnDocuments){        // IF COMPLETE
      logger.i('Insert Complete');  // PRINT LOG
      showMessageBox(context, "Success", _idController.text + " saved completely", actions: [dismissButton(context)]);   //POP UP COMPLETE
    }
    ).catchError((e){               // IF ERROR
        logger.e("Insert Error");   // PRINT LOG
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

  //====================================================================================
  // FUNCTION: CHOOSE FILE
  //====================================================================================
  Future chooseFile() async {
    ImagePicker.pickImage(source: ImageSource.gallery).then((image) {setState(() {_image = image;
    });
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
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      
      });
    });
  }


}