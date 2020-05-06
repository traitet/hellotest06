import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens_seedoc/DMenuPage.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';

class DSignUpPage extends StatefulWidget {
  DSignUpPage({Key key}) : super(key: key);

  @override
  _DSignUpPageState createState() => _DSignUpPageState();
}

class _DSignUpPageState extends State<DSignUpPage> {
// DECLARE VARIABLE
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController()
    ..text = 'traitet@gmail.com';
  TextEditingController _passwordController = TextEditingController()
    ..text = 'computer';
  TextEditingController _confirmController = TextEditingController()
    ..text = 'computer';

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
          title: Text("Sign up", style: TextStyle(color: Colors.white)),
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
                          buildTextFieldEmail(),
                          buildTextFieldPassword(),
                          buildTextFieldPasswordConfirm(),
                          buildButtonSignUp(context),
                          //buildButtonSignUp2(context)
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
  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: _emailController,
            decoration: InputDecoration.collapsed(hintText: "Email"),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 18)));
  }

  //======================================================================
  // TEXT FIELD PASSWORD
  //======================================================================
  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            style: TextStyle(fontSize: 18)));
  }

  //======================================================================
  // TEXT FIELD CONFIRM PASSWORD
  //======================================================================
  Container buildTextFieldPasswordConfirm() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: _confirmController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Re-password"),
            style: TextStyle(fontSize: 18)));
  }

//============================================================================
// WIDGET#2: LOGIN BUTTON
//============================================================================
  Widget buildButtonSignUp(BuildContext context) {
    return InkWell(
        child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Sign up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.green),
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(12),
        ),
        onTap: () {
          signUp();
        });
  }

  //*************************************************************************************************
  // FUNCTION
  //*************************************************************************************************

  //========================================================================
  // FUNCTION SIGN UP
  //========================================================================
  signUp() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmController.text.trim();
    //======================================================================
    // FUNCTION SIGN UP
    //======================================================================    
    if (password == confirmPassword && password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        //======================================================================
        // SHOW LOG AND MESSAGE
        //======================================================================             
        logger.i("Sign up user successful.  on Google Authen");
        showMessageBox(context, "Complete", "Register success",actions: [dismissButton(context)]);
        //======================================================================
        // SIGNUP TO FIREBASE DB
        //======================================================================        
        Firestore.instance.collection("TM_USER").document(email).setData({"email": email, "firstname:": email.split("@")[0]});
        //======================================================================
        // SHOW LOG AND MESSAGE
        //======================================================================             
        logger.i("Sign up user successful. On Firebase DB");
        //======================================================================
        // NAVIGATE TO MENU PAGE
        //======================================================================   
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => DMenuPage(email: email,)),ModalRoute.withName('/'));
      }).catchError((error) {
        logger.e(error.message);
        showMessageBox(context, "Error", error.message,actions: [dismissButton(context)]);
      });
    } else {
      showMessageBox(context, "Error", "Password and Confirm-password is not match.",
          actions: [dismissButton(context)]);
      logger.e("Password and Confirm-password is not match.");
    }
  }
}
