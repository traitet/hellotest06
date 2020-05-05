import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/LoggerService.dart';
import '../screens/MySignUpPage.dart';
// REF: https://benzneststudios.com/blog/flutter/firebase-auth-in-flutter/






class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key}) : super(key: key);
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}
 
class _MyLoginPageState extends State<MyLoginPage> {
  //============================================================================
  // DECLARE VARIABLE
  //============================================================================  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController()..text = 'traitet@gmail.com';
  TextEditingController _passwordController = TextEditingController()..text = 'computer'; 
  //============================================================================
  // OVERRIDE "INIT STATE"
  //============================================================================  
  @override
  void initState(){
      super.initState();
      //========================================================================
      // CHECK LOGIN
      //========================================================================        
      checkAuth(context);
  }
  //============================================================================
  // OVERRIDE "BUILD WIDGET"
  //============================================================================  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //======================================================================
        // APP BAR
        //======================================================================  
        appBar: AppBar(
          title: Text("My Firebase App", style: TextStyle(color: Colors.white)),
        ),
        body: Container(
            //==================================================================
            // BACKGROUND "GREEN"
            //==================================================================            
            color: Colors.green[50],
            //==================================================================
            // CHILD#1 LAYOUT "CENTER"
            //==================================================================              
            child: Center(
              //================================================================
              // CHILD#2: CONTAINER
              //================================================================                
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow[100], Colors.green[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  //============================================================
                  // CHILD#3 COLUMN
                  //============================================================                    
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    //==========================================================
                    // CHILD: 1) TEXT E-MAIL 2) PASSWORD 3) BUTTON
                    //==========================================================                      
                    children: <Widget>[
                      buildTextFieldEmail(),
                      buildTextFieldPassword(),
                      buildButtonSignIn(context),
                     // buildButtonSignInWidget(),
                      buildOtherLine(),
                      buildButtonRegister(context),
                      buildButtonGoogle(context),
                    ],
                  )),
            )));
  }

  
  //============================================================================
  // 1) BUTTON E-MAIL
  //============================================================================ 
  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
          
            controller: _emailController ,
            decoration: InputDecoration.collapsed(hintText: "Email"),
            style: TextStyle(fontSize: 18)));
  }
 
  //==============================================================================
  // 2) BUTTON PASSWORD
  //============================================================================== 
  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: _passwordController ,          
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            style: TextStyle(fontSize: 18)));
  }

  //============================================================================
  // 3.1) BUTTON "SIGN-IN"
  //============================================================================ 
  // Widget buildButtonSignInWidget() {
  //   return InkWell(    
  //     child: Text("Sign in",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontSize: 18, color: Colors.white),
  //           ),
  //       onTap: () {signIn();}, 
           
  //   );
  // }

  //============================================================================
  // 3.2) CONTAINER: SIGN-IN
  //============================================================================ 
   Widget buildButtonSignIn(BuildContext context){
     return InkWell(
       child: Container(
                   constraints: BoxConstraints.expand(height: 50),
          child: Text("Sign in",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(12),  
       ),
           onTap: () {signIn();});
        
      }
      
   
   
    // Container buildButtonSignIn() {
    //   return Container(
    //       constraints: BoxConstraints.expand(height: 50),
    //       child: Text("Sign in",
    //           textAlign: TextAlign.center,
    //           style: TextStyle(fontSize: 18, color: Colors.white)),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
    //       margin: EdgeInsets.only(top: 16),
    //       padding: EdgeInsets.all(12),       
    //   );
    // }

  //==============================================================================
  // FUNCTION#1: SIGN-IN
  //============================================================================== 
  signIn(){
          _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      ).then((user) {
        logger.i("signed in successed for ${user.user.email}");
        checkAuth(context);
      }).catchError((error) {
        logger.e(error);
      });
    }

  //==============================================================================
  // FUNCTION#2: CHECK AUTHEN (USE FOR FIRST PAGE)
  //============================================================================== 
  Future checkAuth(BuildContext context) async {
      // FirebaseUser user = await _auth.currentUser();
      // if (user != null) {
      //   logger.i("Already singed-in");
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => MyApp()));
      // }
      // else {
      //          logger.i("Redirect to login");
      //   // Navigator.pushReplacement(
      //   //     context, MaterialPageRoute(builder: (context) => MyLoginPage()));               
               
      // }
    }

Widget buildOtherLine() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(children: <Widget>[
          Expanded(child: Divider(color: Colors.green[800])),
          Padding(
              padding: EdgeInsets.all(6),
              child: Text("Don’t have an account?",
                  style: TextStyle(color: Colors.black87))),
          Expanded(child: Divider(color: Colors.green[800])),
        ]));
  }

    Widget buildButtonRegister(BuildContext context) {
        return InkWell(
          child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Sign up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.orange[200]),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12),
          ),
           onTap: () => MySignUpPage());
        
      }



Widget buildButtonGoogle(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Login with Google ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.blue[600])),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)),
        onTap: () => loginWithGoogle(context));
  }

Future loginWithGoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount user = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await user.authentication;
 
    await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: userAuth.idToken, accessToken: userAuth.accessToken));
    checkAuth(context); // after success route to home.
  }

  


} // CLASS


