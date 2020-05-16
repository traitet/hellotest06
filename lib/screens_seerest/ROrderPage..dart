//========================================================
// IMPORT
// REF: NAV BAR: https://www.androidthai.in.th/android-flutter/389-bottom-navigation-bar-on-flutter.html
//========================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens_seerest/ROrderItemEditPage.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
import '../widgets_seedoc/BadgeIcon.dart';
// import '../models_seerest/ROrderModel.dart';


//========================================================
// MAIN CLASS
//========================================================  
class ROrderPage extends StatefulWidget {
  @override
  _ROrderPageState createState() => _ROrderPageState();
}

//=============================================================================================
// STATE CLASS
//=============================================================================================  
class _ROrderPageState extends State<ROrderPage> {
  int index = 0;

  //===========================================================================================
  // OVERRICE
  //===========================================================================================  
  @override
  void initState() {
    super.initState();
  }

  //===========================================================================================
  // BUILD UI
  //=========================================================================================== 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Items'),
        actions: <Widget>[IconButton(
            icon: StreamBuilder(
            stream:  Firestore.instance.collection("TT_ORDER").snapshots(),
            builder: (BuildContext context, AsyncSnapshot _shapshot) => BadgeIcon(icon:Icon(Icons.add_shopping_cart, size: 25,),
            badgeCount:  _shapshot.data.documents.length??0        
        ), )
        , onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ROrderPage()),);}     ),],
      ),
      body: StreamBuilder(
         stream: Firestore.instance.collection("TT_ORDER").snapshots(),
         builder:(context, snapshot) {
           if (!snapshot.hasData){return Center(child: Column(children: <Widget>[CircularProgressIndicator(),Text('Loading...') ],),);}
           else
           {
                return ListView.builder(
                //============================================================================
                // 1) DECLARE VARIABLE
                //============================================================================                 
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index)
                 {
                    //========================================================================
                    // GET DATA FROM DB
                    //========================================================================  
                    String _docId = snapshot.data.documents[index].documentID; 
                    String _name =  snapshot.data.documents[index].data["name"];  
                    String _description =  snapshot.data.documents[index].data["description"];  
                    int _qty =  snapshot.data.documents[index].data["qty"]??1;     
                    String _table =  snapshot.data.documents[index].data["table"]??'';  
                    String _imageUrl =  snapshot.data.documents[index].data["_imageUrl"]??'';    
                    String _menuId =  snapshot.data.documents[index].data["_menuId"]??'';                                                                                                                          
                return Padding(padding: const EdgeInsets.all(2.0),
                  child: Card(  
                    child: Container(                   
                      child: InkWell(
                        onTap: () {},                   
                        child: Column(
                          children: <Widget>[  
 
                            widgetBodyText(_docId,_name,_description,_qty,_table,_imageUrl, _menuId),        
                          ],
                        ),
                      ),
                    ),
                  ));
                }, //return#1
              );
           }
         }
      )
    );
  }

  //======================================================
  // WIDGET: BODY TEXT
  //======================================================
  Widget widgetBodyText(String myDocId,String myName, String myDescription, int myQty, String myTable,String myImageUrl, String myMenuId)  { 
  return 
    Container(
      child: Padding(padding: const EdgeInsets.all(4),
        child: Row(children: [
                Expanded(child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        //Text('Order#:' + myDocId + ' Table#' + myTable),
                        Text('x ' + myQty.toString() + ' ' + myName + ' | ' + myDescription),
                    ],
                  ), 
                ),
                Image.network(myImageUrl),
                Row(children: <Widget>[
                  IconButton(onPressed: (){
                      Firestore.instance.collection("TT_ORDER").document(myDocId).delete();
                      showMessageBox(context, "success","Cancel completely",actions: [dismissButton(context)]);                      
                      logger.i(myDocId + 'deleted completly');
                  },icon: Icon(Icons.remove_circle),color: Colors.orange,),
                  IconButton(onPressed: (){

                  Navigator.push(context,MaterialPageRoute(builder: (context) => ROrderItemEditPage(menuId: myDocId,orderItemId: myDocId)));       

                  },icon: Icon(Icons.edit),color: Colors.orange,),
                ],)

          ],
        ),
      ),
    );
  } //widget




}// CLASS





