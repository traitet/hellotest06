import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../screens_seedoc/DDocViewPage.dart';
import '../screens_seedoc/DDocWfSettingPage.dart';
import '../services/LoggerService.dart';
import '../services_seedoc/DDocNew.dart';
import '../services_seedoc/DDocUpdate.dart';
import '../services/ShowNotification.dart';


class DDocCreatePage extends StatefulWidget {
  DDocCreatePage({Key key}) : super(key: key);
  @override
  _DDocCreatePageState createState() => _DDocCreatePageState();
}

  String _timestampstr = DateTime.now().millisecondsSinceEpoch.toString();

class _DDocCreatePageState extends State<DDocCreatePage> {
  //====================================================================================
  // 1) DECLARE VARIABLE FOR CONTROLLER
  //====================================================================================
  final _docIdController = TextEditingController()..text = "D2000002";
  final _usernameController = TextEditingController()..text = "traitet";
  final _docTitleController = TextEditingController()..text = "Petty Cash";
  //====================================================================================
  // 1) DECLARE VARIABLE FOR UPLOAD IMAGE
  //====================================================================================
  File _image;
  String _uploadedFileURL;

  // String _docid = "";
  @override
  //===================================================================================
  // 3) INIT: GET DATA FROM DB
  //===================================================================================
  void initState() {
    super.initState();
    Firestore.instance
        .collection('TT_DOCUMENT').orderBy("docid",descending: true).limit(1).getDocuments()
        .then((value) {
      //=================================================================================
      // 3.1) AFTER GET DATA
      //=================================================================================
      setState(() {
        _timestampstr = DateTime.now().millisecondsSinceEpoch.toString();
        var _docid = value.documents[0].data['docid'];    //DOCID : 8 DIGITS
        var _intno = int.parse(_docid.substring(3)) + 1;
        var _newid = "000000" + _intno.toString();
        var _newdocid = "D20" + _newid.substring(_newid.length-5);
        _docIdController.text = _newdocid;
        Firestore.instance.collection("TT_DOCUMENT").document(_newdocid+'|'+_timestampstr).setData({"docid": _newdocid});
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    //==================================================================================
    // SCAFFOLD
    //==================================================================================
    return Scaffold(
      //================================================================================
      // APP BAR
      //================================================================================
      appBar: AppBar(
        title: Text("Create Doc"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.camera_alt), onPressed: chooseFile),
          _image != null
              ? Image.asset(
                  _image.path,
                  height: 150,
                )
              : Container(height: 10),
        ],
      ),
      //================================================================================
      // BUTTOM NAVIGATE BAR
      //================================================================================
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //========================================================================
              // WIDGET:IMAGE BODY WIDGET
              //========================================================================
              Column(
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      fnConfig(context, _docIdController.text);
                    },
                  ),
                  Text(
                    "Config",
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.save),
                    onPressed: () {
                      fnSave(context, _docIdController.text);
                    },
                  ),
                  Text(
                    "Save",
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.send),
                    onPressed: () {
                      fnSaveSubmit(context, _docIdController.text);
                    },
                  ),
                  Text(
                    "Save & Submit",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      //==================================================================================
      // BODY
      //==================================================================================
      body: ListView(
        children: <Widget>[
          //==============================================================================
          // BUILD WIDGET IMAGE AND TEXT
          //==============================================================================
          widgetBodyImage(),
          widgetBodyText,

          //==============================================================================
          // UPLOAD IMAGE
          //==============================================================================
          RaisedButton(child: Text("Select Image"), onPressed: chooseFile),
          _image != null
              ? Image.asset(
                  _image.path,
                  height: 150,
                )
              : Container(height: 10),

          //==============================================================================
          //INPUT DATA
          //==============================================================================
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'Doc ID', prefixIcon: Icon(Icons.email)),
              controller: _docIdController),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'User Name', prefixIcon: Icon(Icons.verified_user)),
              controller: _usernameController),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'Doc Title', prefixIcon: Icon(Icons.pages)),
              controller: _docTitleController),
          //==============================================================================
          // 2) BUTTON
          //==============================================================================

          RaisedButton(onPressed: () {}, child: Text('CONFIG')),
          RaisedButton(
            onPressed: () async {
              //==========================================================================
              // 3) PRINT LOG
              //==========================================================================
              logger.i("E-mail" + _usernameController.text);
              //==========================================================================
              // 4) VALIDATE
              //==========================================================================
              if (_usernameController.text == "" ||
                  _docTitleController.text == "") {
                showMessageBox(context, "Error", "Please enter Doc Title",
                    actions: [dismissButton(context)]);
                logger.e("Username or password cannot be null");
              } // IF
              //==========================================================================
              // 5) SIGNUP USER
              //==========================================================================
              else {
                //========================================================================
                // 6) WAIT UPLOAD FILE
                //========================================================================
                await uploadFile();
                //========================================================================
                // 7) ADD NEW DOCUMENT
                //========================================================================
                dDocNew(
                    context,
                    {
                      "username": _usernameController.text,
                      "title": _docTitleController.text,
                      "docid": _docIdController.text,
                      "imageurl": _uploadedFileURL,
                      "create_time": DateTime.now()
                    },
                    _docIdController.text);
              }
              //========================================================================
              // 6) BUTTON NAME
              //========================================================================
            },
            child: Text('SAVE'),
          ),
        ],
      ),
    );
  }

  //====================================================================================
  // FUNCTION: CHOOSE FILE
  //====================================================================================
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  //====================================================================================
  // FUNCTION#2: UPLOAD
  //====================================================================================
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
} // END CLASS

//**************************************************************************************************************************/
// FUNCTION
//**************************************************************************************************************************/
//======================================================
// FUNCTION SCAN
//======================================================
void fnScan() {}

//======================================================
// FUNCTION APPROVE
//======================================================
void fnConfig(BuildContext context, String myDocId) {

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => DDocWfSettingPage(
              docid: myDocId,
            )),
  );
  logger.i("Config Success");
    showMessageBox(context, "success", "Config Document($myDocId) completely",
      actions: [dismissButton(context)]);
}

//======================================================
// FUNCTION SAME
//======================================================
void fnSave(BuildContext context, String myDocId) {
  _fnDocNew(context, myDocId);
}

//======================================================
// FUNCTION SAVE AND SUBMIT
//======================================================
void fnSaveSubmit(BuildContext context, String myDocId) {
  _fnDocUpdate(context, myDocId);
  showMessageBox(
      context, "success", "Save and Send Document($myDocId) completely",
      actions: [dismissButton(context)]);
  logger.i("Save and Send Success");
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => DDocViewPage(
              docid: myDocId,
            )),
  );
}

void _fnDocNew(BuildContext context, String myDocId) {
  dDocNew(
      context,
      {
        "username": 'traitet',
        "docid": myDocId,
        "create_time": DateTime.now(),
        "imageurl":
            'https://www.redmineup.com/cms/assets/thumbnail/39805/700/classic_invoice.png?class=border-all+pad-base&token=134deedcbd9393687562eb37db06b84c8e23e753dd61efe2b724a826800e8282',
        "user_detail": {
          "fullname": "Traitet Thepbandansuk",
          "mobileno": "085-6000606",
          "deptid": "D200",
          "deptname": "ITM Dept"
        },
        "title": 'Petty Cash - Submit',
        "workflows": [
          {
            "user": "traitet",
            "action": "submit",
            "createtime": "4 May 2020: 1:00pm",
          },
          {
            "user": "johnson",
            "action": "approve",
            "createtime": "4 May 2020: 1:15pm",
          }
        ]
      },
      myDocId+'|'+_timestampstr);
}

void _fnDocUpdate(BuildContext context, String myDocId) {
  dDocUpdate(
      context,
      {
        "username": 'traitet',
        "docid": myDocId,
        "create_time": DateTime.now(),
        "imageurl":
            'https://www.redmineup.com/cms/assets/thumbnail/39805/700/classic_invoice.png?class=border-all+pad-base&token=134deedcbd9393687562eb37db06b84c8e23e753dd61efe2b724a826800e8282',
        "user_detail": {
          "fullname": "Traitet Thepbandansuk",
          "mobileno": "085-6000606",
          "deptid": "D200",
          "deptname": "ITM Dept"
        },
        "title": 'Petty Cash - Submit',
        "workflows": [
          {
            "user": "traitet",
            "action": "submit",
            "createtime": "4 May 2020: 1:00pm",
          },
          {
            "user": "johnson",
            "action": "approve",
            "createtime": "4 May 2020: 1:15pm",
          }
        ]
      },
      myDocId+'|'+_timestampstr);
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

//======================================================
// WIDGET: BODY TEXT
//======================================================
Widget widgetBodyText = Container(
  child: Padding(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  child: Text(
                    "E-Document: 5 Mar 2020, 13:30",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text(
                "Mr. Kandersteg Switzerland",
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              )
            ],
          ),
        ),
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        Text("41"),
      ],
    ),
  ),
);
