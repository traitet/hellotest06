import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/LoggerService.dart';



class MySignUpPage extends StatefulWidget {
  MySignUpPage({Key key}) : super(key: key);
 
  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}
 
class _MySignUpPageState extends State<MySignUpPage> {
// DECLARE VARIABLE
FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign up", style: TextStyle(color: Colors.white)),
        ),
        body: Container(
            color: Colors.green[50],
            child: Center(
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
                      buildButtonSignUp2(context)
                    ],
                  )),
            )));
  }
 



 
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


signUp() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmController.text.trim();
    if (password == confirmPassword && password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        logger.i("Sign up user successful.");
      }).catchError((error) {
         logger.e(error.message);
      });
    } else {
      logger.e("Password and Confirm-password is not match.");
    }
  }

  Container buildButtonSignUp(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text("Sign up",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }


  //============================================================================
  // 3.1) BUTTON "SIGN-IN"
  //============================================================================ 
  Widget buildButtonSignUp2(BuildContext context) {
    return InkWell(    
      child: Text("Sign up",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
            ),
        onTap: () {
          signUp();
          }, 
           
    );

    
  }



  
}
 