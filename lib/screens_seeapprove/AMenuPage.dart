import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/screens_seeapprove/ACreateDocCarReqPage.dart';
import 'package:hellotest06/screens_seeapprove/ACreateDocPage.dart';
import 'package:hellotest06/screens_seeapprove/ACreateDocPrPage.dart';
import 'package:hellotest06/screens_seeapprove/ACreateDocTypePage.dart';
import 'package:hellotest06/screens_seeapprove/ASearchDocPage.dart';
import 'package:hellotest06/screens_seeapprove/ASearchDocTypePage.dart';
import 'package:hellotest06/widgets/BadgeIcon.dart';

class AMenuPage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  AMenuPage({Key key, @required this.email,}): super(key: key);  
  @override
  _AMenuPageState createState() => _AMenuPageState();
}

class _AMenuPageState extends State<AMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Approve: Menu'),
//=============================================================================================
// ACTION (BUTTON -> ORDER PAGE)
//=============================================================================================      
      actions: <Widget>[
//=============================================================================================
// SHOW ICON
//=============================================================================================         
        IconButton(icon: StreamBuilder(
          initialData: 0,
//=============================================================================================
// GET DATA FROM DB
//=============================================================================================           
          stream: Firestore.instance.collection('ATT_DOC').snapshots(),
          builder: (BuildContext context, AsyncSnapshot _snapshot) => BadgeIcon(icon: Icon(Icons.add_shopping_cart, size: 25,),
//=============================================================================================
// SHOW จำนวน Order Item จาก DB (TT_ORDER)
//=============================================================================================           
          badgeCount: _snapshot.data.documents.length,)
        )
//=============================================================================================
// กดปุ่มแล้วไป SEARCH DOC Page
//=============================================================================================         
        , onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ASearchDocPage(email: widget.email,docType: 'PR',)),); 


        })
      ],
    ),      
      body: ListView(children: <Widget>[
             RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ACreateDocTypePage(email: widget.email)),);}, child: Text('Create Doc Type'),),          
             RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ACreateDocPage(email: widget.email)),);}, child: Text('Issue Doc - GENERAL'),),   
             RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ACreateDocCarReqPage(email: widget.email)),);}, child: Text('Issue Doc Car Request - CAR'),),    
             RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ACreateDocPrPage(email: widget.email)),);}, child: Text('Issue Doc PR - PR'),),                          
             RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ASearchDocTypePage(email: widget.email,)),);}, child: Text('Search Doc Type'),),     
             RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ASearchDocPage(email: widget.email,docType: 'PR',)),);}, child: Text('Approve: Search Doc / My Tasks'),),     
                                                            
      ],),
      
    );
  }
}