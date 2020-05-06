//========================================================================================
// 1) IMPORT
//========================================================================================
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'DDocViewPage.dart';

//========================================================================================
// 2) MAIN CLASS
//========================================================================================
class DDocSearchPage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  DDocSearchPage({Key key, @required this.email,}): super(key: key);
  //======================================================================================
  // OVERRIDE
  //======================================================================================
  @override
  _DDocSearchPageState createState() => _DDocSearchPageState();
  }

//========================================================================================
// 3) CREATE UI
//========================================================================================
class _DDocSearchPageState extends State<DDocSearchPage> {
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
        appBar: AppBar(title: Text("Search Doc: " + widget.email),),
      //==================================================================================
      // BODY
      //==================================================================================        
        body: StreamBuilder(
      //==================================================================================
      // GET DATA FROM API
      //==================================================================================          
          stream: Firestore.instance.collection("TT_DOCUMENT").where("email", isEqualTo: widget.email).snapshots(),
          builder: (context, snapshot) {
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
                            Navigator.push(context,MaterialPageRoute(builder: (context) => DDocViewPage(docid: snapshot.data.documents[index].documentID,)));
                          },                   
                            child: Column(
                              children: <Widget>[                                 
                                ListTile(
                                title: Text(snapshot.data.documents[index].documentID),
                                subtitle: Text(snapshot.data.documents[index].data["docno"]),
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
