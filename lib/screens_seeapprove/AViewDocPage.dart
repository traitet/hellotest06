import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AViewDocPage extends StatefulWidget {
   //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  final String docId;
  AViewDocPage({Key key, @required this.email,@required this.docId,}): super(key: key);  
  @override
  _AViewDocPageState createState() => _AViewDocPageState();
}

class _AViewDocPageState extends State<AViewDocPage> {
  final _idController = TextEditingController()..text = '';
  final _nameController = TextEditingController()..text = '';
  final _descriptionController = TextEditingController()..text = '';
//========================================================================================
// 4) GET DATA FROM DB ?? YES
//========================================================================================
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection("ATT_DOC").document(widget.docId).get().then((value) {
      setState(() {
        _idController.text = value.data["id"];
        _nameController.text = value.data["name"];
        _descriptionController.text = value.data["description"];             
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Approve: View Doc'),),
      body: ListView(children: <Widget>[
//======================================================================
// TEXT INPUT
//======================================================================         
            //TextFormField(decoration: InputDecoration(labelText: '*E-mail', prefixIcon: Icon(Icons.email)),controller: _createdByController),
            TextFormField(decoration: InputDecoration(labelText: '*Name', prefixIcon: Icon(Icons.near_me)),controller: _nameController,),
            TextFormField(decoration: InputDecoration(labelText: '*Description', prefixIcon: Icon(Icons.vpn_key)),controller: _descriptionController),                         
    
      ],),
      
    );
  }
}