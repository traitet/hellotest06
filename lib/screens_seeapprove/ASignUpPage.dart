//=====================================================================================
// 1) IMPORT
//=====================================================================================
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';

//=====================================================================================
// 2) MAIN CLASS
//=====================================================================================
class ASignUpPage extends StatefulWidget {
  @override
  _ASignUpPageState createState() => _ASignUpPageState();
}

//=====================================================================================
// 3) STATE CLASS
//=====================================================================================
class _ASignUpPageState extends State<ASignUpPage> {
  //===================================================================================
  // 1) DECLARE VARIABLE
  //===================================================================================
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullnameController = TextEditingController();  
  final _lineidController = TextEditingController();    
  final _mobilenoController = TextEditingController();  
  final _companyController = TextEditingController();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup Page'),),
      body: SafeArea(child: ListView(    
        children: <Widget>[
          //==========================================================================
          // 1) TEXTBOX 
          //==========================================================================              
          TextFormField(decoration: InputDecoration(labelText: '*E-mail', prefixIcon: Icon(Icons.email)),controller: _usernameController),
          TextFormField(decoration: InputDecoration(labelText: '*Full Name', prefixIcon: Icon(Icons.near_me)),controller: _fullnameController,),
          TextFormField(decoration: InputDecoration(labelText: '*Password', prefixIcon: Icon(Icons.vpn_key)),controller: _passwordController),                         
          TextFormField(decoration: InputDecoration(labelText: 'Line ID', prefixIcon: Icon(Icons.network_cell)),controller: _lineidController),
          TextFormField(decoration: InputDecoration(labelText: 'Mobile No', prefixIcon: Icon(Icons.phone)),controller: _mobilenoController,keyboardType: TextInputType.number,),                                    
          TextFormField(decoration: InputDecoration(labelText: 'Company', prefixIcon: Icon(Icons.home)),controller: _companyController,),      
          //==========================================================================
          // 2) BUTTON
          //==========================================================================                
          RaisedButton(onPressed: ()
          {
            //========================================================================
            // 3) PRINT LOG
            //======================================================================== 
            logger.i("E-mail" + _usernameController.text);
            logger.i("password " + _passwordController.text);
            //========================================================================
            // 4) VALIDATE
            //========================================================================             
            if (_usernameController.text == "" || _passwordController.text ==""){
              showMessageBox(context, "Error", "Please enter username or password", actions: [dismissButton(context)]);
              logger.e("Username or password cannot be null");              
            } // IF
            //========================================================================
            // 5) ASignup USER
            //========================================================================             
            else {
              //ASignupUser(context, {"username": _usernameController.text,"password": _passwordController.text, "fullname":_fullnameController.text}, _usernameController.text);
              fnASignupUser({"username": _usernameController.text, "password": _passwordController.text,"fullname": _fullnameController.text,"lineid": _lineidController.text ,"mobileno": _mobilenoController.text ,"company": _companyController.text},_usernameController.text);              
            }  
            //========================================================================
            // 6) BUTTON NAME
            //========================================================================                         
          },child: Text('SAVE'),),      
        ],
      )
      ),
    );
  }

    //==============================================================================
    // 1) FUNCTION
    //============================================================================== 
fnASignupUser(Map<String, dynamic> myData, String myDocumentId){
      return
    //==============================================================================
    // 2) CALL SIGN UP
    //==============================================================================       
    Firestore.instance.collection("ATM_USER").document(myDocumentId).setData(myData).then((returnData) {
    //==============================================================================
    // 3) SHOW MESSAGE AFTER SUCCESS
    //==============================================================================         
    showMessageBox(context, "Success", "Register User($myDocumentId) completely", actions: [dismissButton(context)]);
    logger.i("setData Success");
    //============================================================================
    // 4) IF ERROR
    //============================================================================         
      }).catchError((e){
        showMessageBox(context, "Error", "Register User($myDocumentId) Error", actions: [dismissButton(context)]);        
        logger.e("setDAta Error");
        logger.e(e);
      });
  
}

  
}