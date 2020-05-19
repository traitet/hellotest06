import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hellotest06/screens_seeapprove/AMenuPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hellotest06/screens_seeapprove/AResetPasswordPage.dart';
import 'package:hellotest06/screens_seeapprove/ASignUpPage.dart';
import 'package:hellotest06/services/LoggerService.dart';
import 'package:hellotest06/services/ShowNotification.dart';
//==============================================================================
// MAIN CLASS
//============================================================================== 
class ALoginPage extends StatefulWidget {
  @override
  _ALoginPageState createState() => _ALoginPageState();
}
//==============================================================================
// STATE CLASS
//============================================================================== 
class _ALoginPageState extends State<ALoginPage> {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final _usernameController = TextEditingController()..text = 'traitet@gmail.com';  
      final _passwordController = TextEditingController()..text = 'computer';      

  //==============================================================================
  // OVERRIDE
  //==============================================================================          
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Login'),),
    body: ListView(children: <Widget>[
      TextFormField(decoration: InputDecoration(labelText: '*E-mail', prefixIcon: Icon(Icons.email)),controller: _usernameController),
      TextFormField(decoration: InputDecoration(labelText: '*Password', prefixIcon: Icon(Icons.vpn_key)),controller: _passwordController,),   
      RaisedButton(onPressed: (){fnSignIn();}, child: Text('Login'),),     
      RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ASignUpPage()),);}, child: Text('Sign-up'),),     
      RaisedButton(onPressed: (){fnLoginWithGoogle();}, child: Text('Login Google'),),   
      RaisedButton(onPressed: (){fnSignOutGoogle();}, child: Text('Sign Out Google'),),         
      RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AResetPasswordPage()),);}, child: Text('Reset Password'),),                   
    ],)
    );
  } //WIDGET

//================================================================================
// FUNCTION#1: SIGN-IN (FIREBASE)
//================================================================================ 
  fnSignIn(){
          _firebaseAuth.signInWithEmailAndPassword(email: _usernameController.text.trim(),password: _passwordController.text.trim()
      ).then((user) {
        logger.i("signed in successed for ${user.user.email}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => AMenuPage(email: _usernameController.text,)),);
      }).catchError((error) {
        logger.e(error);
        showMessageBox(context, "Error", "Login error " + error.toString(), actions: [dismissButton(context)]);
        });
    }
//================================================================================
// FUNCTION#2: LOGIN BY GOOGLE
//================================================================================ 
  Future fnLoginWithGoogle() async {
      // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/contacts.readonly',],);
      final GoogleSignInAccount _googleSignInAccount  = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleSignInAuthentication  = await _googleSignInAccount.authentication;
      final AuthCredential _authCredential = GoogleAuthProvider.getCredential(idToken: _googleSignInAuthentication.idToken, accessToken: _googleSignInAuthentication.accessToken);
      final AuthResult authResult = await _firebaseAuth.signInWithCredential(_authCredential);
      final FirebaseUser user = authResult.user;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid); 
      showMessageBox(context, "Success", 'Login by Google Complte with user: ' + _googleSignInAccount.displayName , actions: [dismissButton(context)]);
      Container(padding: EdgeInsets.all(8.0),width: 80,child: Image.network(_googleSignInAccount.photoUrl));
    }

//================================================================================
// FUNCTION#3: SIGNOUT
//================================================================================ 
  void fnSignOutGoogle() async{
    await _googleSignIn.signOut();
    logger.i("User Sign Out");
    showMessageBox(context, "Success", 'Sign-out completedly' , actions: [dismissButton(context)]);    
  }

}//CLASS