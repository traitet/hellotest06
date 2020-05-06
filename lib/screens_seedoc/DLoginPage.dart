import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import '../screens_seedoc/DMenuPage.dart';
import '../screens_seedoc/DSignUpPage.dart';
import '../screens_seedoc/DResetPasswordPage.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
import '../services_seedoc/DFirebaseAuth.dart'
    as MyFirebaseAuthen;
// import '../services_seedoc/DFirebaseAuthFB.dart'
//     as MyFirebaseAuthenFB;

//============================================================================
// DECLARE VARIABLE
//============================================================================
final FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController _emailController = TextEditingController()
  ..text = 'traitet@gmail.com';
TextEditingController _passwordController = TextEditingController()
  ..text = 'computer';

String verificationId;

class DLoginPage extends StatefulWidget {
  @override
  _DLoginPageState createState() => _DLoginPageState();
}

class _DLoginPageState extends State<DLoginPage> {
  //============================================================================
  // OVERRIDE "INIT STATE"
  //============================================================================
  @override
  void initState() {
    super.initState();
    //========================================================================
    // CHECK LOGIN
    //========================================================================
    checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("See Doc Login"),
      ),
      body: Container(
        color: Colors.green[50],
        child: Center(
          child: ListView(
            children: [
              BuildWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}

//============================================================================
// BUILD WIDGET
//============================================================================
class BuildWidgets extends StatelessWidget {
  const BuildWidgets({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient:
            LinearGradient(colors: [Colors.yellow[100], Colors.green[100]]),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildTextFieldEmail(),
          buildTextFieldPassword(),
          buildButtonSignIn(context),
          buildOtherLine("Don’t have an account?"),
          buildButtonSignUp(context),
          buildOtherLine("Others sign-in"),
          buildButtonGoogle(context),
          // buildButtonFacebook(context),
          buildButtonLoginWithSms(context),
          buildOtherLine("Forget password"),
          buildButtonForgetPassword(context),
        ],
      ),
    );
  }
}

//*************************************************************************************************
// WIDGET
//*************************************************************************************************
//============================================================================
// WIDGET#1: TEXTFIELD E-MAIL
//============================================================================
Container buildTextFieldEmail() {
  return Container(
      padding: EdgeInsets.all(12),
      //margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration.collapsed(hintText: "E-mail"),
        style: TextStyle(fontSize: 18),
      ));
}

//============================================================================
// WIDGET#2: TEXTFIELD PASSWORD
//============================================================================
Container buildTextFieldPassword() {
  //var _passwordController;
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

//============================================================================
// WIDGET#3: LOGIN BUTTON
//============================================================================
Widget buildButtonSignIn(BuildContext context) {
  return InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.green),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12),
      ),
      onTap: () {
        fnSignIn(context);
      });
}

//============================================================================
// WIDGET#4: OTHER LINE
//============================================================================
Widget buildOtherLine(String _text) {
  return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(children: <Widget>[
        Expanded(child: Divider(color: Colors.green[800])),
        Padding(
            padding: EdgeInsets.all(6),
            child: Text(_text, style: TextStyle(color: Colors.black87))),
        Expanded(child: Divider(color: Colors.green[800])),
      ]));
}

//============================================================================
// WIDGET#5: BUTTON SIGNUP
//============================================================================
Widget buildButtonSignUp(BuildContext context) {
  return InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text("Sign up",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.pink),
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
      ),
      onTap: () {
        //====================================================================
        // REDIRECT TO SIGNUP PAGE
        //==================================================================== 
        Navigator.push(context, MaterialPageRoute(builder: (context) => DSignUpPage()));
      });
}

//============================================================================
// WIDGET#6: BUTTON LOGIN GOOGLE
//============================================================================
Widget buildButtonGoogle(BuildContext context) {
  return InkWell(
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Login by Google ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.red),
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12)),
      onTap: () => loginWithGoogle(context));
}

//============================================================================
// WIDGET#7: BUTTON LOGIN FACEBOOK
//============================================================================
// Widget buildButtonFacebook(BuildContext context) {
//   return InkWell(
//       child: Container(
//           constraints: BoxConstraints.expand(height: 50),
//           child: Text("Login by Facebook ",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 18, color: Colors.white)),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16), color: Colors.blue),
//           margin: EdgeInsets.only(top: 12),
//           padding: EdgeInsets.all(12)),
//       onTap: () => loginWithFacebook(context));
// }

//============================================================================
// WIDGET#8: BUTTON LOGIN WITH SMS
//============================================================================
Widget buildButtonLoginWithSms(BuildContext context) {
  return InkWell(
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Login with SMS",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.orange),
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12)),
      onTap: () => loginWithSms(context));
}

//============================================================================
// WIDGET#9: BUTTON FORGET PASSWORD
//============================================================================
Widget buildButtonForgetPassword(BuildContext context) {
  return InkWell(
      child: Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Text("Forget Password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.green),
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(12)),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DResetPasswordPage()));
      });
}

//*************************************************************************************************
// FUNCTION
//*************************************************************************************************
//===================================================================================
// FUNCTION#1: LOGIN BY GOOGLE
//===================================================================================
Future loginWithGoogle(BuildContext context) async {


  MyFirebaseAuthen.signInWithGoogle().whenComplete(() async {
    //GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/contacts.readonly',],);
    //GoogleSignInAccount _user = await _googleSignIn.signIn();
    
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {return DMenuPage(email: 'traitet@gmail.com');},),
    );
  });


    // GoogleSignIn _googleSignIn = GoogleSignIn(
    //   scopes: [
    //     'https://www.googleapis.com/auth/contacts.readonly',
    //   ],
    // );
    // GoogleSignInAccount user = await _googleSignIn.signIn();
    // GoogleSignInAuthentication userAuth = await user.authentication;
 
    // await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
    //     idToken: userAuth.idToken, accessToken: userAuth.accessToken));
    // checkAuth(context); // after success route to home.
  }

  //================================================================================
  // FUNCTION#2: CHECK AUTHEN (USE FOR FIRST PAGE)
  //================================================================================ 
  Future checkAuth(BuildContext context) async {
      //============================================================================
      // 1) GET USER
      //============================================================================    
      FirebaseUser user = await _auth.currentUser();
      if (user != null) {
        //==========================================================================
        // SHOW LOG
        //==========================================================================          
        logger.i("Already singed-in");
        //==========================================================================
        // ROUTE TO MENU PAGE (REPLACE LOGIN PAGE)
        //==========================================================================        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DMenuPage(email: user.email,)));
      }
      else {
        logger.i("Redirect to login");
        // Navigator.pushReplacement(
        // context, MaterialPageRoute(builder: (context) => LoginPage()));               
      }
    }


// //===============================================================================
// // FUNCTION#2: CHECK AUTHEN (USE FOR FIRST PAGE)
// //===============================================================================
// Future checkAuth(BuildContext context) async {
//   // FirebaseUser user = await _auth.currentUser();
//   // if (user != null) {
//   //   logger.i("Already singed-in");
//   //   Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(
//   //           builder: (context) => DMenuPage(
//   //                 username: 'traitet@gmail.com',
//   //               )));
//   // }
// }



//============================================================================
// FUNCTION#3: LOGIN BY FACEBOOK
//============================================================================
// loginWithFacebook(BuildContext context) {
//   MyFirebaseAuthenFB.signInWithFacebook().whenComplete(() {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) {
//           return DMenuPage(username: 'Auth by FB');
//         },
//       ),
//     );
//   });
// }

//================================================================================
// FUNCTION#4: LOGIN BY SMS
//================================================================================
loginWithSms(BuildContext context) {}

//================================================================================
// FUNCTION#1: SIGN-IN
//================================================================================
fnSignIn(BuildContext _context) {
  //==============================================================================
  // LOGIN BY GOOGLE FIREBASE
  //==============================================================================
  _auth.signInWithEmailAndPassword(email: _emailController.text.trim(),password: _passwordController.text.trim())
      .then((user) {
    logger.i("signed in successed for ${user.user.email}");
    Navigator.pushReplacement(_context,MaterialPageRoute(builder: (context) => DMenuPage(email: _emailController.text.trim(),)),);
  //==============================================================================
  // NOT SUCCESS LOGIN
  //==============================================================================    
  }).catchError((error) {
    logger.e(error);
    showMessageBox(_context, "Error", "Invalidate username or password",
        actions: [dismissButton(_context)]);
  });
}
