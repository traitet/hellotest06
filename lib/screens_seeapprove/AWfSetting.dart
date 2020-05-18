import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/models_seeapprove/AWfSettingModel.dart';
import 'package:hellotest06/services/LoggerService.dart';
import 'package:hellotest06/services/ShowNotification.dart';

class AWfSettingPage extends StatefulWidget {
   //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  final String docId;  
  AWfSettingPage({Key key, @required this.email,@required this.docId,}): super(key: key);  
  @override
  _AWfSettingPageState createState() => _AWfSettingPageState();
}

class _AWfSettingPageState extends State<AWfSettingPage> {
//======================================================================
// DECLARE TEXT EDIT CONTROLLER
//====================================================================== 
      //final _createdByController = TextEditingController()..text;
      final _approve1Controller = TextEditingController()..text = 'traitet@hotmail.com';
      final _approve2Controller = TextEditingController()..text = 'traitet_th@aisin-ap.com';
      final _approve3Controller = TextEditingController()..text = 'hrtraitet@gmail.com';      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Doc WF: ' + widget.docId),),
      body: ListView(children: <Widget>[
//======================================================================
// TEXT INPUT
//======================================================================         
            TextFormField(decoration: InputDecoration(labelText: '*_approve1', prefixIcon: Icon(Icons.near_me)),controller: _approve1Controller,),
            TextFormField(decoration: InputDecoration(labelText: '*_approve2', prefixIcon: Icon(Icons.people_outline)),controller: _approve2Controller),        
            TextFormField(decoration: InputDecoration(labelText: '*_approve3', prefixIcon: Icon(Icons.people)),controller: _approve3Controller),                                      
//======================================================================
// SAVE INPUT
//======================================================================             
            RaisedButton(onPressed: (){
//======================================================================
// SAVE TO DB
//======================================================================               
              AWfSettingModel myModel = AWfSettingModel(docId: widget.docId,approve1: _approve1Controller.text,approve2: _approve2Controller.text,approve3: _approve3Controller.text);
              logger.i(myModel.toFileStone());
              String _timestampstr = DateTime.now().millisecondsSinceEpoch.toString(); 
              Firestore.instance.collection('ATT_DOC_WF').document(_timestampstr).setData(myModel.toFileStone());
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
             }, child: Text('Save New Document WF'),),    






      ],),
      
    );
  }
}