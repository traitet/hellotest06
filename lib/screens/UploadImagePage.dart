import 'dart:io';    
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore    
import 'package:flutter/material.dart';    
import 'package:image_picker/image_picker.dart'; // For Image Picker    
import 'package:path/path.dart' as Path; 

//============================================================================
// 1) DECLARE VARIABLE
//============================================================================   
//============================================================================
// REF WEB: https://www.c-sharpcorner.com/article/upload-image-file-to-firebase-storage-using-flutter/
// REF WEB (Get SHA1, fingerprint): https://benzneststudios.com/blog/flutter/google-login-with-firebase-auth-in-flutter/
//============================================================================
 

File _image;    
String _uploadedFileURL;
class UploadImagePage extends StatefulWidget {
  
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
//============================================================================
// UPLOAD IMAGE WIDGET
//============================================================================    
  @override
  Widget build(BuildContext context) {    
    return Scaffold(    
      appBar: AppBar(    
        title: Text('Firestore File Upload'),    
      ),    
      body: Center(    
        child: Column(    
          children: <Widget>[    
            Text('Selected Image'),    
            _image != null    
                ? Image.asset(    
                    _image.path,    
                    height: 150,    
                  )    
                : Container(height: 150),    
            _image == null    
                ? RaisedButton(    
                    child: Text('Choose File'),    
                    onPressed: chooseFile,    
                    color: Colors.cyan,    
                  )    
                : Container(),    
            _image != null    
                ? RaisedButton(    
                    child: Text('Upload File'),    
                    onPressed: uploadFile,    
                    color: Colors.cyan,    
                  )    
                : Container(),    
            _image != null    
                ? RaisedButton(    
                    child: Text('Clear Selection'),    
                    onPressed: (){},    
                  )    
                : Container(),    
            Text('Uploaded Image'),    
            _uploadedFileURL != null    
                ? Image.network(    
                    _uploadedFileURL,    
                    height: 150,    
                  )    
                : Container(),    
          ],    
        ),    
      ),    
    );  
  }

//============================================================================
// FUNCTION: CHOOSE FILE
//============================================================================
Future chooseFile() async {    
   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
     setState(() {    
       _image = image;    
     });    
   });    
 }  

 //============================================================================
// FUNCTION#2: UPLOAD
//============================================================================
 Future uploadFile() async {    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('chats/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');    
   storageReference.getDownloadURL().then((fileURL) {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });    
   });    
 }

} // END CLASS



