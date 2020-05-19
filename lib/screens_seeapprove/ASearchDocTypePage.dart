
//=============================================================================================
// IMPORT 
//=============================================================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/models_seeapprove/ADocTypeModel.dart';
import 'package:hellotest06/screens_seeapprove/ASearchDocPage.dart';
import 'package:hellotest06/widgets/BadgeIcon.dart';
// import 'package:golfep1/services/LoggerService.dart';

//=============================================================================================
// MAIN CLASS
//=============================================================================================  
class ASearchDocTypePage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  ASearchDocTypePage({Key key, @required this.email,}): super(key: key);



  @override
  _ASearchDocTypePageState createState() => _ASearchDocTypePageState();
}

//=============================================================================================
// STATE CLASS
//=============================================================================================  
class _ASearchDocTypePageState extends State<ASearchDocTypePage> {
  @override
  Widget build(BuildContext context) {
//=============================================================================================
// SCAFFOLD
//=============================================================================================     
    return Scaffold( appBar: AppBar(
      title: Text('Search Doc Type'),
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
// กดปุ่มแล้วไป Order Page
//=============================================================================================         
        , onPressed: (){})
      ],
    ),
//=============================================================================================
// BODY -> STEAMBUILDER
//=============================================================================================  
    body: StreamBuilder(
//=============================================================================================
// GET DATA FROM DB (FIREBASE ->SNAPSHOT(TABLE))
//=============================================================================================        
      stream: Firestore.instance.collection('ATT_DOC_TYPE').snapshots(),
//=============================================================================================
// BUILDER
//=============================================================================================        
        builder: (context, snapshot){
          if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
          } //IF
          else{
//=============================================================================================
// ITEM BUILDER / LISTVIEW
//=============================================================================================          
          return ListView.builder(
            itemCount: snapshot.data.documents.length, //จำนวนที่แสดง
            itemBuilder: (context, _index){
//=============================================================================================
// SNAPSHOT (DB) -> MODEL (ข้อมูลเมนูอาหารที่ดึงมาจาก DB)
//============================================================================================= 
              var _model = ADocTypeModel.fromFilestore(snapshot.data.documents[_index]);
              String _docId = snapshot.data.documents[_index].documentID;
              String _id = _model.id;
              String _name = _model.name;   
              String _description = _model.description;          
              String _imageUrl = _model.imageUrl;                                    
 
//=============================================================================================
// CREATE CARD 
//=============================================================================================           
              return Card(
                child: Container(child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ASearchDocPage(docType: _id,email: widget.email,)));
                  },
                  child: Row(children: <Widget>[
//=============================================================================================
// IMAGE
//=============================================================================================                      
                        Container(
                          padding: EdgeInsets.all(8.0),
                          width: 120,
                          child: Image.network(_imageUrl )),                        
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ID:' + _docId + _id +  ', Name:' + _name + ', Description:' + _description ),
                    )),                  
//=============================================================================================
// SHOW ICON
//=============================================================================================         
        IconButton(icon: StreamBuilder(initialData: 0,
        stream: Firestore.instance.collection('ATT_DOC').where('docType',isEqualTo: _id).snapshots(),builder: (BuildContext context, AsyncSnapshot _snapshot) => BadgeIcon(icon: Icon(Icons.add_shopping_cart, size: 25,),badgeCount: _snapshot.data.documents.length,))  , onPressed: (){}),
        
                  ],),
                )),
              );
            },//ITEM BUILDER
          );
        } //ELSE
      }, // BUILDER
    ),    
  );
  } //WIDGET
} //CLASS



