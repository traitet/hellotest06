import 'package:flutter/material.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
// import '../services_seedoc/dDocNewWfSetting.dart';

class DDocWfSettingPage extends StatefulWidget {
  final String docid;
  DDocWfSettingPage({Key key,  @required  this.docid}) : super(key: key);

  @override
  _DDocWfSettingPageState createState() => _DDocWfSettingPageState();
}

class _DDocWfSettingPageState extends State<DDocWfSettingPage> {
// DECLARE VARIABLE
  TextEditingController _approve1Controller = TextEditingController()
    ..text = 'traitet@gmail.com';
  TextEditingController _approve2Controller = TextEditingController()
    ..text = 'satit_po123@gmail.com';
  TextEditingController _approve3Controller = TextEditingController()
    ..text = 'traitet@hotmail.com';

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
          title: Text("Workflow Settup: " , style: TextStyle(color: Colors.white)),
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
                          containerTextField1("Manager1"),
                          containerTextField2("Manager2"),    
                          containerTextField3("Manager3"),                                                   
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
  //======================================================================
  // TEXT FIELD EMAIL
  //======================================================================
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

    //======================================================================
  // TEXT FIELD PASSWORD
  //======================================================================
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
  //======================================================================
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
              } // IF
              //==========================================================================
              // 5) SIGNUP USER
              //==========================================================================
              else {
                //========================================================================
                // 7) ADD NEW DOCUMENT
                //========================================================================
                // dDocNewWfSetting(
                //     context,
                //     {
                //       "docid": widget.docid,
                //       "approve1": _approve1Controller.text,
                //       "approve2": _approve2Controller.text,
                //       "approve3": _approve3Controller.text,
                //       "create_time": DateTime.now()
                //     },
                //     widget.docid);
              }

        });
  }







  
}
