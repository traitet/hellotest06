import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellotest06/models_seerest/RMenuModel.dart';
import 'package:image_picker/image_picker.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
import 'package:path/path.dart' as Path;


//=====================================================================================
// MAIN CLASS
//=====================================================================================
class RMenuNewPage extends StatefulWidget {
  final String docId;
  //======================================================================================
  // PARAMETER
  //======================================================================================
  RMenuNewPage({Key key,this.docId}): super(key: key);
  //====================================================================================
  // OVERRIDE
  //==================================================================================== 
  @override
  _RMenuNewPageState createState() => _RMenuNewPageState();
}

//=====================================================================================
// STATE CLASS
//=====================================================================================
class _RMenuNewPageState extends State<RMenuNewPage> {
  //===================================================================================
  // 1) DECLARE VARIABLE
  //===================================================================================
  final _menuIdController = TextEditingController();
  final _nameController = TextEditingController(); 
  final _descriptionController = TextEditingController();  
  final _priceController = TextEditingController();  
  RMenuModel myMenuModel;
  var _image;
  String _imageURL;  
  //======================================================================================
  // 3) INIT: GET DATA FROM DB
  //======================================================================================
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('TM_REST_MENU').document(widget.docId).get().then((myDocument) {
      //===================================================================================
      // 3.1) AFTER GET DATA
      //===================================================================================
      setState(() {

        myMenuModel = RMenuModel.fromFilestore(myDocument);
        _menuIdController.text = myMenuModel.menuId;        
        _nameController.text = myMenuModel.name;        
        _descriptionController.text = myMenuModel.description;
        _priceController.text = myMenuModel.price.toString();

      if (myDocument.data.length == 0 ) {

      } 
      });
    });
  }
  //=========================================================================================
  // BUILD WIDGET
  //=========================================================================================
  @override
  Widget build(BuildContext context) {

    //=======================================================================================
    // RETURN SCAFFOLD
    //=======================================================================================      

    return Scaffold(
      appBar: AppBar(title: Text('Restaurant Food Menu' ),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(child: ListView(    
          children: <Widget>[
            //==============================================================================
            // 1) TEXTBOX 
            //==============================================================================                
            TextFormField(decoration: InputDecoration(labelText: 'Menu ID', prefixIcon: Icon(Icons.perm_identity)),controller: _menuIdController),
            TextFormField(decoration: InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.people)),controller: _nameController),          
            TextFormField(decoration: InputDecoration(labelText: 'Description', prefixIcon: Icon(Icons.description)),controller: _descriptionController,),  
            TextFormField(decoration: InputDecoration(hintText: 'Price', labelText: 'Price', prefixIcon: Icon(Icons.confirmation_number)),controller: _priceController,keyboardType: TextInputType.number,),                             
          //==============================================================================
          // BUILD WIDGET IMAGE AND TEXT
          //==============================================================================
         _image != null ? Image.asset(_image.path,height: 200,): widgetBodyImage(),
          //==============================================================================
          // UPLOAD IMAGE         
          //==============================================================================
          RaisedButton(child: Text("Select Image"), onPressed: chooseFile),                          
            //==============================================================================
            // 2) BUTTON
            //==============================================================================                
            Container(
              // margin: EdgeInset.all(50.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RaisedButton(onPressed: ()
                async {
                  //========================================================================
                  // 3) PRINT LOG
                  //======================================================================== 
                  logger.i("Name" + _nameController.text);
                  logger.i("Description " + _descriptionController.text);
                  //========================================================================
                  // 4) VALIDATE
                  //========================================================================             
                  if (_nameController.text == "" || _descriptionController.text ==""){
                    showMessageBox(context, "Error", "Please enter username or Emp ID", actions: [dismissButton(context)]);
                    logger.e("Name or Description cannot be null");              
                  } // IF
                  //========================================================================
                  // 5) SIGNUP USER
                  //========================================================================             
                  else {
                    //======================================================================
                    // UPDATE IMAGE
                    //====================================================================== 
                  await fnUploadFile();
                    //======================================================================
                    // UPDATE TO DATABASE
                    //====================================================================== 
                  if (_imageURL != null){
                    //======================================================================
                    // PREPARE VALUE
                    //====================================================================== 
                    myMenuModel = RMenuModel(
                      menuId: _menuIdController.text,
                      name: _nameController.text,                      
                      description: _descriptionController.text,
                      price: double.parse(_priceController.text),
                      imageUrl: _imageURL,
                      );
                  logger.i("setData Success");
                    //======================================================================
                    // UPDATE DATA TO DB
                    //======================================================================                    
                    Firestore.instance.collection("TM_REST_MENU").document(widget.docId==null?DateTime.now().millisecondsSinceEpoch.toString():widget.docId).setData(myMenuModel.toFileStone()).then((returnData) {
                    //============================================================================
                    // 4) SHOW MESSAGE AFTER SUCCESS
                    //============================================================================         
                    showMessageBox(context, "Success", "Register Menu($myMenuModel) to completely", actions: [dismissButton(context)]);
                    logger.i("setData Success");
                    // GET DOCUMENT ID  
                    //============================================================================
                    //5)SHOW MESSAGE IF ERROR
                    //============================================================================         
                    }).catchError((e){
                      logger.e("setDAta Error");
                      logger.e(e);
                    });
                }

                  }              
                  //========================================================================
                  // 6) BUTTON NAME
                  //========================================================================                         
                },child: Text('SAVE'),),
              ),
            ),      
          ],
        )
        ),
       ),
    );
  }

  //====================================================================================
  // FUNCTION: CHOOSE FILE
  //====================================================================================
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {setState(() {_image = image;
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


