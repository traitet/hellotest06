import 'package:flutter/material.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';

//============================================================================
// MAIN CLASS
//============================================================================
class DDocWfSettingPage extends StatefulWidget {
  //==========================================================================
  // CLASS PARAMETER
  //==========================================================================  
  final String docid;
  DDocWfSettingPage({Key key,  @required  this.docid}) : super(key: key);
  //==========================================================================
  // OVERIDE STATE
  //==========================================================================
  @override
  _DDocWfSettingPageState createState() => _DDocWfSettingPageState();
}

//============================================================================
// STATE CLASS
//============================================================================
class _DDocWfSettingPageState extends State<DDocWfSettingPage> {
  //============================================================================
  // DECLARE VAIRABLE
  //============================================================================
  TextEditingController _approve1Controller = TextEditingController()..text = 'traitet@gmail.com';
  TextEditingController _approve2Controller = TextEditingController()..text = 'satit_po@gmail.com';
  TextEditingController _approve3Controller = TextEditingController()..text = 'traitet@hotmail.com';

  @override
  //============================================================================
  // BUILD UI
  //============================================================================
  Widget build(BuildContext context) {
    return Scaffold(
        //======================================================================
        // APP BAR
        //======================================================================
        appBar: AppBar(
          title: Text("Workflow Setting: " + widget.docid.split('|')[0], style: TextStyle(color: Colors.white)),
        ),
        //======================================================================
        // BODY
        //======================================================================
        body: Container(
            color: Colors.green[50],
            child: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                              colors: [Colors.yellow[100], Colors.green[100]])),
                      margin: EdgeInsets.all(32),
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          containerTextField1("Approve 1"),
                          containerTextField2("Approve 1"),    
                          containerTextField3("Approve 1"),                                                   
                          buildButtonSave(context),
                  
                        ],
                      )),
                ),
              ],
            )));
  }

  //*************************************************************************************************
  // BUILD CONTAINER
  //*************************************************************************************************
  //==========================================================================
  // TEXT FIELD EMAIL
  //==========================================================================
  Container containerTextField1(String myText) {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: _approve1Controller,
            decoration: InputDecoration.collapsed(hintText: myText),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 18)));
  }

    //========================================================================
  // TEXT FIELD PASSWORD
  //==========================================================================
  Container containerTextField2(String myText,) {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: _approve2Controller,
            decoration: InputDecoration.collapsed(hintText: myText),
            style: TextStyle(fontSize: 18)));
  }

      //======================================================================
  // TEXT FIELD PASSWORD
  //==========================================================================
  Container containerTextField3(String myText,) {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: _approve3Controller,
            decoration: InputDecoration.collapsed(hintText: myText),
            style: TextStyle(fontSize: 18)));
  }

//============================================================================
// WIDGET#2: LOGIN BUTTON
//============================================================================
  Widget buildButtonSave(BuildContext context) {
    return InkWell(
        child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Save",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.green),
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(12),
        ),
        onTap: () {

              //==========================================================================
              // 4) VALIDATE
              //==========================================================================
              if (_approve1Controller.text == "" ||
                  _approve2Controller.text == "") {
                showMessageBox(context, "Error", "Please enter Approver 1 and 2",
                    actions: [dismissButton(context)]);
                logger.e("Approver 1 and 2 cannot be null");
              } 

        });
  }







  
}
