//============================================================================
// 1) IMPORT
//============================================================================
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/SearchDetailPage.dart';

//===========================================================
// 2) MAIN CLASS
//===========================================================
class SearchPage extends StatefulWidget {
      //=======================================================
    // 1) ARAMETER AND CONSTUCTURE METHOD
    //=======================================================
    final String username;
      SearchPage({Key key, @required this.username,})
      : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
  }

//========================================================================================
// 3) CREATE UI
//========================================================================================
class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }
//========================================================================================
// 4) CREATE WIDGET
//========================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //==================================================================================
      // APP BAR
      //==================================================================================
        appBar: AppBar(
          title: Text("User in System"),
        ),
      //==================================================================================
      // BODY
      //==================================================================================        
        body: StreamBuilder(
      //==================================================================================
      // GET DATA FROM API
      //==================================================================================          
          stream: Firestore.instance.collection("catalog").snapshots(),builder: (context, snapshot) {
            //============================================================================
            // IF NO DATA
            //============================================================================            
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: <Widget>[
                    //====================================================================
                    // LOADNING....
                    //====================================================================                     
                    CircularProgressIndicator(),
                    Text("Loading . . . "),
                  ],
                ),
              );
            //============================================================================
            // IF HAVE DATA
            //============================================================================               
            } else {
              return ListView.builder(
                //========================================================================
                // 1) SET LIST VIEW LENGTH
                //========================================================================                 
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    //====================================================================
                    // UI: CARD
                    //====================================================================                      
                    child: Card(
                        child: Container(                       
                        child: InkWell(
                          onTap: () {
                            //============================================================
                            // CLICK EVENT: GO ITEM_PAGE
                            //============================================================                              
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SearchDetailPage( username: snapshot.data.documents[index].documentID,)));
                          },                   
                            child: Column(
                              children: <Widget>[                                 
                                ListTile(
                                title: Text(snapshot.data.documents[index].documentID),
                                subtitle: Text(snapshot.data.documents[index].data["username"]),
                                ),
                              ],
                            ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        );
  }
}
