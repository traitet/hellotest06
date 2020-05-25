import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/screens_seeapprove/AWfSetting.dart';
import 'package:hellotest06/services/LoggerService.dart';

class ACreateDocPage extends StatefulWidget {
   //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;

  ACreateDocPage({Key key, @required this.email}): super(key: key);  
  @override
  _ACreateDocPageState createState() => _ACreateDocPageState();
}

class _ACreateDocPageState extends State<ACreateDocPage> {
//======================================================================
// DECLARE TEXT EDIT CONTROLLER
//====================================================================== 
      //final _createdByController = TextEditingController()..text;
      GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();      
      final _nameController = TextEditingController()..text = 'Request General';
      final _descriptionController = TextEditingController()..text = 'Requested General for any document '; 
      final String _timestampstr = DateTime.now().millisecondsSinceEpoch.toString();        
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
            RaisedButton(onPressed: (){
//======================================================================
// SAVE TO DB
//======================================================================               
              // ADocModel myModel = ADocModel(
              //     docType: 'GENERAL', 
              //     id: _timestampstr,
              //     name: _nameController.text,
              //     description: _descriptionController.text, 
              //     createdBy: widget.email,
              //     imageUrl: 'https://firebasestorage.googleapis.com/v0/b/hellotest06-88fae.appspot.com/o/download.png?alt=media&token=7193690e-bd2b-4880-b949-8267024beed6',              
              //     //workFlows:  WorkFlows(userName: 'traitet@gmail.com',action: 'APPROVE', comment: 'approved ok'),
              //   );                      
              // logger.i(myModel.toFileStone());
              // Firestore.instance.collection('ATT_DOC').document(_timestampstr).setData(myModel.toFileStone());

              var _data = {
                  'docType': 'GENERAL', 
                  'id': _timestampstr,
                  'name': _nameController.text,
                  'description': _descriptionController.text, 
                  'createdBy': widget.email,
                  'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/hellotest06-88fae.appspot.com/o/download.png?alt=media&token=7193690e-bd2b-4880-b949-8267024beed6',              
                  'workFlows': [
                    {'id':1,'userName': 'traitet@gmail.com','action': 'APPROVE', 'comment': 'approved ok'},
                    {'id':2,'userName': 'traitet@gmail.com','action': 'APPROVE', 'comment': 'approved ok'},
                    {'id':3,'userName': 'satit_po@gmail.com','action': 'APPROVE', 'comment': 'approved ok leve 2'},                    
                  ]
                 };                     
                logger.i(_data);
              Firestore.instance.collection('ATT_DOC').document(_timestampstr).setData(_data);


              // final dbRef = FirebaseDatabase.instance.reference().child('ATT_DOC').child('workFlows');
              // dbRef.push().set({
              //   'id':3,'userName': 'satit_po@gmail.com','action': 'APPROVE', 'comment': 'approved ok leve 99'
              // }).then((value){
              //   Scaffold.of(context).showSnackBar(SnackBar(content: Text('Succesfully added')));
              // }).catchError((onError) {
              //   logger.i(onError);
              // });


//======================================================================
// SAVE COMPLETE
//======================================================================               
              setState(() {
                logger.i('Insert Order Completed');
                //showMessageBox(context, "success", "Register Document($_timestampstr) to Firestore Database completely", actions: [dismissButton(context)]);
                scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Register Document($_timestampstr) to Firestore Database completely",style: TextStyle(color: Colors.white)),backgroundColor: Colors.green[300],));                
              });

//======================================================================
// BUTTON TEXT
//====================================================================== 
             }, child: Text('Save New Document'),),        
//======================================================================
// BUTTON TEXT (CREATE DOC WF)
//====================================================================== 
              RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AWfSettingPage(email: widget.email,docId: _timestampstr,)),); },child: Text('Create WF')),

      ],),
      
    );
  }
}