
//========================================================================================
// 1) IMPORT
//========================================================================================
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//========================================================================================
// 2) ITEM PAGE
//========================================================================================
class SearchDetailPage extends StatefulWidget {
  //========================================================================================
  // DECLARE VAIRABLE (PRODUCTION NAME, PRODUCTION DESCRIPTION) ??? WIDGET.pdname
  //========================================================================================
  final String username;
  SearchDetailPage({Key key, @required this.username})
      : super(key: key);

  @override
  _SearchDetailPageState createState() => _SearchDetailPageState();
}

//========================================================================================
// 3) SHOW DATA
//========================================================================================
class _SearchDetailPageState extends State<SearchDetailPage> {
  String company = "Please wait...";
  String fullname;
  String lineid;
  String mobileno;

//========================================================================================
// 4) GET DATA FROM DB ?? YES
//========================================================================================
  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("catalog")
        .document(widget.username) 
        .get()
        .then((value) {
      setState(() {
        company = value.data["company"];
        fullname = value.data["fullname"];
        mobileno = value.data["mobileno"];
        lineid = value.data["lineid"];
      });
    });
  }
//========================================================================================
// 4) GEN UI
//========================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//========================================================================================
// 5) APP BAR
//========================================================================================      
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Colors.blue,
      ),
//========================================================================================
// 6) BODY
//========================================================================================      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//========================================================================================
// 7) SHOW TEXT (PRODUCT NAME)
//========================================================================================            
            Text(
 //========================================================================================
// 8) SHOW WIDGET.PRNAME
//========================================================================================                
              widget.username??'',      //??? WHERE FROM
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
            ),
            Text( company??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text( fullname??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),   
            Text( mobileno??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text( lineid??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),                      
          ],
        ),
      ),
    );
  }
}

