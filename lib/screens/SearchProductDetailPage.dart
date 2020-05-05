
//========================================================================================
// 1) IMPORT
//========================================================================================
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//========================================================================================
// 2) ITEM PAGE
//========================================================================================
class SearchProductDetailPage extends StatefulWidget {
  //========================================================================================
  // DECLARE VAIRABLE (PRODUCTION NAME, PRODUCTION DESCRIPTION) ??? WIDGET.pdname
  //========================================================================================
  final String id;
  SearchProductDetailPage({Key key, @required this.id})
      : super(key: key);

  @override
  _SearchProductDetailPageState createState() => _SearchProductDetailPageState();
}

//========================================================================================
// 3) SHOW DATA
//========================================================================================
class _SearchProductDetailPageState extends State<SearchProductDetailPage> {
  String _id = "Please wait...";
  String _name;
  String _description;
  String _remark;
 // double _price;

//========================================================================================
// 4) GET DATA FROM DB ?? YES
//========================================================================================
  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("product")
        .document(widget.id) 
        .get()
        .then((value) {
      setState(() {
        _id = value.data["id"];
        _name = value.data["name"];
        //_price = value.data["price"];
        _description = value.data["description"];
        _remark = value.data["remark"];
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
        title: Text(widget.id),
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
              widget.id??'',      //??? WHERE FROM
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
            ),
            Text( _id??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text( _name??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),   
            //Text( _price??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text( _description??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),  
            Text( _remark??'', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),                      
          ],
        ),
      ),
    );
  }
}

