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

//======================================================================================
// MAIN CLASS
//======================================================================================
class DDocNewPage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  DDocNewPage({Key key, @required this.email,}): super(key: key);
  //====================================================================================
  // OVERRIDE
  //====================================================================================  
  @override
  _DDocNewPageState createState() => _DDocNewPageState();
}

  String _timestampstr = DateTime.now().millisecondsSinceEpoch.toString();

//======================================================================================
// STATE CLASS
//======================================================================================
class _DDocNewPageState extends State<DDocNewPage> {
  //====================================================================================
  // 1) DECLARE VARIABLE FOR CONTROLLER
  //====================================================================================
  final _docNoController = TextEditingController()..text = "D2000002";
  final _usernameController = TextEditingController()..text = "traitet";
  final _docTitleController = TextEditingController()..text = "Petty Cash";
  //====================================================================================
  // 1) DECLARE VARIABLE FOR UPLOAD IMAGE
  //====================================================================================
  File _image;
  String _uploadedFileURL;
  String _docid;

  // String _docid = "";
  @override
  //=====================================================================================
  // 3) INIT: GET DATA FROM DB
  //=====================================================================================
  void initState() {
    super.initState();
    Firestore.instance.collection('TT_DOCUMENT').orderBy("docno",descending: true).limit(1).getDocuments()
        .then((myDocuments) {
      //=================================================================================
      // 3.1) AFTER GET DATA
      //=================================================================================
      setState(() {
        //===============================================================================
        // 1) NOT FOUND IN DB
        //===============================================================================          
        String _docno = ''; 
        String _newdocno = '';
        if (myDocuments.documents.length==0){_docno="D2000000";}
        else {_docno = myDocuments.documents[0].data['docno'];}    //DOCID : 8 DIGITS
        //===============================================================================
        // 1) GET TIME STAMPT E.G. 1588756759854
        //===============================================================================        
        _timestampstr = DateTime.now().millisecondsSinceEpoch.toString();
        //===============================================================================
        // 2) FIND NEW DOCNO E.G. D2000004
        //===============================================================================           
        try
        {
          var _intno = int.parse(_docno.substring(3)) + 1;
          _newdocno = "000000" + _intno.toString();
          _newdocno = "D20" + _newdocno.substring(_newdocno.length-5);
        }
        catch(error){
          _newdocno = "D20000001";
          logger.e(error.toString());
        }
        //===============================================================================
        // 3) FIND DOC ID (KEY)  E.G. D2000004||1588756759854
        //=============================================================================== 
        _docid = _newdocno+'|'+_timestampstr;                  
        _docNoController.text = _newdocno;

        //===============================================================================
        // 4) SAVE DOC ID INTO DB (WITHOUT DATA)
        //===============================================================================           
        Firestore.instance.collection("TT_DOCUMENT").document(_docid).setData({"docno": _newdocno,"email":widget.email});
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
        actions: <Widget>[IconButton(icon: Icon(Icons.camera_alt), onPressed: chooseFile),],
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
              Column(children: <Widget>[IconButton(iconSize: 30.0,icon: Icon(Icons.settings),onPressed: () {fnDocWfSetting(context, _docid);},),Text("Config",)],),
              Column(children: <Widget>[IconButton(iconSize: 30.0,icon: Icon(Icons.save),onPressed: () {fnSave(context, _docid, _docNoController.text,widget.email);},),Text("Save",)],),
              Column(children: <Widget>[IconButton(iconSize: 30.0,icon: Icon(Icons.send),onPressed: () {fnSaveSubmit(context, _docid, _docNoController.text,widget.email);},),Text("Save and Submit",)],),                            
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
          _image != null ? Image.asset(_image.path,height: 200,): widgetBodyImage(),
          widgetBodyText,
          //==============================================================================
          // UPLOAD IMAGE         
          //==============================================================================
          RaisedButton(child: Text("Select Image"), onPressed: chooseFile),

          //==============================================================================
          //INPUT DATA
          //==============================================================================
          TextFormField(decoration: InputDecoration(labelText: 'Doc ID', prefixIcon: Icon(Icons.email)),controller: _docNoController),
          TextFormField(decoration: InputDecoration(labelText: 'User Name', prefixIcon: Icon(Icons.verified_user)),controller: _usernameController),
          TextFormField(decoration: InputDecoration(labelText: 'Doc Title', prefixIcon: Icon(Icons.pages)),controller: _docTitleController),
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
              if (_usernameController.text == "" || _docTitleController.text == "") {
                showMessageBox(context, "Error", "Please enter Doc Title", actions: [dismissButton(context)]);
                logger.e("Username or password cannot be null");
              } // IF
              //==========================================================================
              // 5) SIGNUP USER
              //==========================================================================
              else {
                //========================================================================
                // 6) WAIT UPLOAD FILE
                //========================================================================
                await fnUploadFile();
                //========================================================================
                // 7) ADD NEW DOCUMENT
                //========================================================================
                if (_uploadedFileURL != null){
                dDocNew(
                    context,
                    {
                      "username": _usernameController.text,
                      "title": _docTitleController.text,
                      "docno": _docNoController.text,
                      "imageurl": _uploadedFileURL,
                      "create_time": DateTime.now(),
                      "is_creater": true,
                    },
                    _docNoController.text);}
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
// FUNCTION CONFIG
//======================================================
void fnDocWfSetting(BuildContext context, String myDocId) {
  Navigator.push(context,MaterialPageRoute(builder: (context) => DDocWfSettingPage(docid: myDocId,)),  );
}

//======================================================
// FUNCTION SAME
//======================================================
void fnSave(BuildContext context, String myDocId, String myDocNo,String myEmail) {
  _fnDocNew(context, myDocId, myDocNo, myEmail);
}

//======================================================
// FUNCTION SAVE AND SUBMIT
//======================================================
void fnSaveSubmit(BuildContext context, String myDocId, String myDocNo,String myEmail)  {
  _fnDocUpdate(context, myDocId, myDocNo,myEmail);
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DDocViewPage(docid: myDocId,)),);
}

void _fnDocNew(BuildContext context, String myDocId, String myDocNo, String myEmail) {
  dDocNew(context,
      {
        "email": myEmail,
        "username": 'traitet',
        "docno": myDocNo,
        "create_time": DateTime.now(),
        "is_creater": true,        
        "imageurl":  'https://www.redmineup.com/cms/assets/thumbnail/39805/700/classic_invoice.png?class=border-all+pad-base&token=134deedcbd9393687562eb37db06b84c8e23e753dd61efe2b724a826800e8282',
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
      myDocId);
}

void _fnDocUpdate(BuildContext context, String myDocId, String myDocNo, String myEmail) {
  dDocUpdate(
      context,
      {
        "email": myEmail,
        "username": 'traitet',
        "docno": myDocNo,
        "create_time": DateTime.now(),
        "is_creater": true,        
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
      myDocId);
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
