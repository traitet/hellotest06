
//=============================================================================================
// IMPORT 
//=============================================================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/models_seeapprove/ADocModel.dart';
import 'package:hellotest06/screens_seeapprove/AViewDocPage.dart';
import 'package:hellotest06/screens_seelastminute/LViewDealPage.dart';
import 'package:hellotest06/widgets/BadgeIcon.dart';
// import 'package:golfep1/services/LoggerService.dart';

//=============================================================================================
// MAIN CLASS
//=============================================================================================  
class LSearchDealPage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  final String docType;
  LSearchDealPage({Key key, @required this.email, @required this.docType,}): super(key: key);


//=============================================================================================
// OERRIDE
//=============================================================================================  
  @override
  _LSearchDealPageState createState() => _LSearchDealPageState();
}

//=============================================================================================
// STATE CLASS
//=============================================================================================  
class _LSearchDealPageState extends State<LSearchDealPage> {
  bool _isCreater = true;
  @override
  Widget build(BuildContext context) {
//=============================================================================================
// SCAFFOLD
//=============================================================================================     
    return Scaffold( appBar: AppBar(
      title: Text('Search Doc / My Tasks'),
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
          stream: Firestore.instance.collection('LTT_DEAL').where('docType',isEqualTo: widget.docType).snapshots(),
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
      stream: Firestore.instance.collection('LTT_DEAL').where('docType',isEqualTo: widget.docType).snapshots(),
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
              var _model = ADocModel.fromFilestore(snapshot.data.documents[_index]);
              String _docId = snapshot.data.documents[_index].documentID;
              String _name = _model.name;
              String _description = _model.description;
              String _imageUrl = _model.imageUrl;
              String _createdBy = _model.createdBy;           
//=============================================================================================
// CREATE CARD 
//=============================================================================================           
              return Card(
                child: Container(child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LViewDealPage(docId: snapshot.data.documents[_index].documentID,email: widget.email,)));
                  },
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
//=============================================================================================
// IMAGE
//=============================================================================================                      
                        Container(padding: EdgeInsets.all(8.0),width: 80,child: Image.network(_imageUrl)),
//=============================================================================================
// TEXT
//=============================================================================================                                                  
                        Expanded(child: Text(_docId + ' Doc Name: ' + _name + ' ' + _description + _createdBy)),   
//=============================================================================================
// DELETE
//=============================================================================================                                        
                        IconButton(icon: Icon(Icons.remove_circle), onPressed: (){Firestore.instance.collection('LTT_DEAL').document(_docId).delete();}),
                      ],),
//=============================================================================================
// APPROVE, REJECT BUTTON
//=============================================================================================   
                    Row(
                      children: <Widget>[
                        Visibility(visible: _isCreater, child: Expanded(child: Padding(padding: const EdgeInsets.all(8.0),child: RaisedButton(onPressed: (){}, child: Text('Recall'),),))),
                        Visibility(visible: _isCreater, child: Expanded(child: Padding(padding: const EdgeInsets.all(8.0),child: RaisedButton(onPressed: (){}, child: Text('Cancel '),),))),  
                        Visibility(visible: !_isCreater, child: Expanded(child: Padding(padding: const EdgeInsets.all(8.0),child: RaisedButton(onPressed: (){}, child: Text('Approve'),),))),
                        Visibility(visible: !_isCreater, child: Expanded(child: Padding(padding: const EdgeInsets.all(8.0),child: RaisedButton(onPressed: (){}, child: Text('Reject'),),))),                          
                      ],
                    ),  
                  ],
//=============================================================================================
// END MAIN COLUMN
//============================================================================================= 
                  ),
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



