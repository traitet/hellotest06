//===========================================================
// 1) IMPORT
//===========================================================
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../services/LoggerService.dart';
import '../services/SetDBFoodMenu.dart';
import '../services/ShowNotification.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

//===========================================================
// 2) MAIN CLASS
//===========================================================
class SetDBFoodMenuPage extends StatefulWidget {
  @override
  _SetDBFoodMenuPageState createState() => _SetDBFoodMenuPageState();
}

//===========================================================
// 3) MAIN UI
//===========================================================
class _SetDBFoodMenuPageState extends State<SetDBFoodMenuPage> {
  // final _usernameController = TextEditingController();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _remarkController = TextEditingController();
  final String _dbCatalogName = "TM_FOOD_MENU";
  File _image;
  String _uploadedFileURL;
  

  @override
  //=======================================================
  // 1) WIDGET
  //=======================================================
  Widget build(BuildContext context) {
    return Scaffold(
      //===================================================
      // 2) APP BAR
      //===================================================
      appBar: AppBar(
        title: Text("Maintain Food Menu"),
      ),
      //===================================================
      // 3) BODY
      //===================================================
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //======================================================================
                // 1) TEXT
                //======================================================================
                SizedBox(
                  height: 40.0,
                ),
                Center(
                    child: Text(
                  'Dont worry. Register Food Menu is only 1 minute.',
                )),
                Center(
                    child: Text(
                  'Just fill details below !!',
                )),
                //=====================================================================
                // 2) TEXT CONTROL
                //======================================================================
                TextFormField(
                    decoration: InputDecoration(
                        labelText: '*Menu ID', prefixIcon: Icon(Icons.vpn_key)),
                    controller: _idController),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: '*Menu Name', prefixIcon: Icon(Icons.title)),
                  controller: _nameController,
                ),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: '*Menu Description',
                        prefixIcon: Icon(Icons.description)),
                    controller: _descriptionController),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Remark', prefixIcon: Icon(Icons.note)),
                    controller: _remarkController),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: '*Price',
                      prefixIcon: Icon(Icons.confirmation_number)),
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                ),
                //=====================================================================
                // 3) BUILD UPLOAD IMAGE
                //======================================================================
                RaisedButton(
                    child: Text('Selected Image'), onPressed: chooseFile),
                _image != null
                    ? Image.asset(
                        _image.path,
                        height: 150,
                      )
                    : Container(height: 150),
                //=====================================================================
                // 3) BUTTON
                //======================================================================
                SizedBox(
                  height: 10.0,
                ),
                //======================================================================
                // 4) REGISTER MENU BUTTON
                //======================================================================
                buildRaisedButton(context)
              ]),
        ),
      )),
    );
  }



  //===================================================================================
  // 2) REGISTER MENU BUTTON
  //===================================================================================
  RaisedButton buildRaisedButton(BuildContext context) {
    return RaisedButton(
      child: Text("Save new Food Menu"),
      onPressed: () {
        logger.i("username: " + _nameController.text);
        logger.i("password" + _idController.text);
        //=============================================================================
        // VALIDATE TEXT
        //=============================================================================
        if (_nameController.text == "" || _idController.text == "") {
          showMessageBox(context, "Error", "Please enter menu ID and Name",
              actions: [dismissButton(context)]);
          logger.e("ID or name can't be null");
        }
        //=============================================================================
        // INSERT DATA TO DB
        //=============================================================================
        else {

          

          uploadFile();

         
  
          setDBFoodMenu(context, _dbCatalogName, _idController.text, {
            "id": _idController.text,
            "name": _nameController.text,
            "description": _descriptionController.text,
            "remark": _remarkController.text,
            "price": _priceController.text,
            "fileUrl": _uploadedFileURL
          });


        } // else
      }, //onPressed
    );
  } // REISED BUTTON

  //==================================================================================
  // FUNCTION: CHOOSE FILE
  //==================================================================================
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  //==================================================================================
  // FUNCTION#2: UPLOAD
  //==================================================================================
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    logger.i('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  void clearFile() {}
} //END CLASS
