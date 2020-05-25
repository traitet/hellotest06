import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/screens_seelastminute/LCreateDeal.dart';
import 'package:hellotest06/screens_seelastminute/LSearchDealPage.dart';
import 'package:hellotest06/widgets/BadgeIcon.dart';

class LMenuPage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  LMenuPage({Key key, @required this.email,}): super(key: key);  
  @override
  _LMenuPageState createState() => _LMenuPageState();
}

class _LMenuPageState extends State<LMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu: Last Minute Deal'),
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
          stream: Firestore.instance.collection('LTT_DEAL').snapshots(),
          builder: (BuildContext context, AsyncSnapshot _snapshot) => BadgeIcon(icon: Icon(Icons.add_shopping_cart, size: 25,),
//=============================================================================================
// SHOW จำนวน Order Item จาก DB (TT_ORDER)
//=============================================================================================           
          badgeCount: _snapshot.data.documents.length,)
        )
//=============================================================================================
// กดปุ่มแล้วไป SEARCH DOC Page
//=============================================================================================         
        , onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LSearchDealPage(email: widget.email,docType: 'DEAL',)),); 


        })
      ],
    ),      
      body: ListView(children: <Widget>[
             RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LCreateDealPage(email: widget.email)),);}, child: Text('Create Last Minute Deal'),),                                  
             RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LSearchDealPage(email: widget.email,docType: 'DEAL',)),);}, child: Text('Search Last Minute Deail'),),     
                                                            
      ],),
      
    );
  }
}