//========================================================
// IMPORT
// REF: NAV BAR: https://www.androidthai.in.th/android-flutter/389-bottom-navigation-bar-on-flutter.html
//========================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import '../models_seerest/ROrderModel.dart';


//========================================================
// MAIN CLASS
//========================================================  
class ROrderPage extends StatefulWidget {
  @override
  _ROrderPageState createState() => _ROrderPageState();
}

//========================================================
// STATE CLASS
//========================================================  
class _ROrderPageState extends State<ROrderPage> {
  int index = 0;

  //========================================================
  // OVERRICE
  //========================================================  
  @override
  void initState() {
    super.initState();
  }

  //========================================================
  // BUILD UI
  //======================================================== 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Items'),
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
                return Padding(padding: const EdgeInsets.all(2.0),
                  child: Card(  
                    child: Container(                   
                      child: InkWell(
                        onTap: () {},                   
                        child: Column(
                          children: <Widget>[  
 
                            widgetBodyText(_docId,_name,_description,_qty,_table,_imageUrl),        
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
  Widget widgetBodyText(String myDocId,String myName, String myDescription, int myQty, String myTable,String myImageUrl)  { 
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
                Column(children: <Widget>[
                  
                  IconButton(onPressed: (){},icon: Icon(Icons.edit),color: Colors.orange,),
                ],)

          ],
        ),
      ),
    );
  } //widget




}// CLASS





