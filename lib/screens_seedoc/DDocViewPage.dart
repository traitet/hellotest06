import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';

//==========================================================================================
// 1) MAIN CLASS
//==========================================================================================
class DDocViewPage extends StatefulWidget {
  //========================================================================================
  // DECLARE VARIABLE
  //========================================================================================
  final String docid;
  DDocViewPage({Key key, @required this.docid}) : super(key: key);
  //========================================================================================
  // OVERRIDE
  //========================================================================================
  @override
  _DDocViewPageState createState() => _DDocViewPageState();
}

//==========================================================================================
// 2) STATE CLOASS
//==========================================================================================
class _DDocViewPageState extends State<DDocViewPage> {
  //========================================================================================
  // 2) DECLARE VARIABLE (DATA FROM DB)
  //========================================================================================
  String _docid = '';
  String _title = '';
  String _username = '';

  @override
  //========================================================================================
  // 3) INIT: GET DATA FROM DB
  //========================================================================================
  void initState() {
    super.initState();
    Firestore.instance
        .collection('TT_DOCUMENT')
        .document(widget.docid)
        .get()
        .then((value) {
      //===================================================================================
      // 3.1) AFTER GET DATA
      //===================================================================================
      setState(() {
        _username = value.data['username'];
        _docid = value.data['docid'];
        _title = value.data['title'];
      });
    });
  }

  //===================================================================================
  // 4) BUILD UI
  //===================================================================================
  @override
  Widget build(BuildContext context) {
    //=================================================================================
    // SCAFFOLD
    //=================================================================================
    return Scaffold(
      //===============================================================================
      // APP BAR
      //===============================================================================
      appBar: AppBar(
        title: Text("View Doc: " + widget.docid),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                fnScan(context);
              })
        ],
      ),
      //===============================================================================
      // BUTTOM NAVIGATE BAR
      //===============================================================================
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //========================================================================
              // WIDGET:IMAGE BODY WIDGET
              //========================================================================
              Column(
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.backspace),
                    onPressed: () {
                      fnRecall(context, _docid);
                    },
                  ),
                  Text(
                    "Recall",
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.home),
                    onPressed: () {
                      fnReject(context, _docid);
                    },
                  ),
                  Text(
                    "Reject",
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.send),
                    onPressed: () {
                      fnApprove(context, _docid);
                    },
                  ),
                  Text(
                    "Approve",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      //===============================================================================
      // BODY
      //===============================================================================
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            //===========================================================================
            // BUILD WIDGET IMAGE AND TEXT
            //===========================================================================
            widgetBodyImage(),
            widgetBodyText(_title??''),
            Text(
              _docid ?? 'Loading...',
            ),
            Text(
              _title ?? '',
            ),
            Text(
              _username ?? '',
            ),
          ],
        ),
      ),
    );
  }
}

//**************************************************************************************************************************/
// FUNCTION
//**************************************************************************************************************************/
//======================================================
// FUNCTION RECALL
//======================================================
void fnRecall(BuildContext context, String myDocId) {
  showMessageBox(context, "success",
      "Recall Document($myDocId) to Firestore Database completely",
      actions: [dismissButton(context)]);
  logger.i("Recall Success");
}

//======================================================
// FUNCTION REJECT
//======================================================
void fnReject(BuildContext context, String myDocId) {
  showMessageBox(context, "success",
      "Reject Document($myDocId) to Firestore Database completely",
      actions: [dismissButton(context)]);
  logger.i("Reject Success");
}

//======================================================
// FUNCTION APPROVE
//======================================================
void fnApprove(BuildContext context, String myDocId) {
  showMessageBox(context, "success",
      "Approve Document($myDocId) to Firestore Database completely",
      actions: [dismissButton(context)]);
  logger.i("Approve Success");
}

//======================================================
// FUNCTION SCAN
//======================================================
void fnScan(BuildContext context) {
  showMessageBox(context, "success", "Please take photo of your document",
      actions: [dismissButton(context)]);
  logger.i("Taking photo Success");
}

//**************************************************************************************************************************/
// WIDGET
//**************************************************************************************************************************/
//======================================================
// WIDGET: BUTTOM BUTTON BAR
//======================================================
Column columnButtomButtonBar(BuildContext context, myIconData, String myLabel) {
  return Column(
    children: <Widget>[
      IconButton(
        iconSize: 30.0,
        icon: Icon(myIconData),
        onPressed: () {},
      ),
      Text(
        myLabel,
      )
    ],
  );
}

//======================================================
// WIDGET:IMAGE BODY WIDGET
//======================================================
Widget widgetBodyImage() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/images/bg01.jpg',
          width: 300, height: 200, fit: BoxFit.cover),
    );

//======================================================
// WIDGET: BODY TEXT
//======================================================
Widget widgetBodyText(String _title) => Container(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      child: Text(
                        "E-Document: 5 Mar 2020, 13:30",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _title,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red[500],
            ),
            Text("41"),
          ],
        ),
      ),
    );
