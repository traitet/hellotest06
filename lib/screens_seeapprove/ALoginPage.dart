import 'package:flutter/material.dart';
import 'package:hellotest06/screens_seeapprove/AMenuPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hellotest06/services/LoggerService.dart';
import 'package:hellotest06/services/ShowNotification.dart';

class ALoginPage extends StatefulWidget {
  @override
  _ALoginPageState createState() => _ALoginPageState();
}

class _ALoginPageState extends State<ALoginPage> {
      final _usernameController = TextEditingController()..text = 'traitet@gmail.com';  
      final _passwordController = TextEditingController()..text = 'password';      
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;  
         
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Login'),),
    body: Column(children: <Widget>[
      TextFormField(decoration: InputDecoration(labelText: '*E-mail', prefixIcon: Icon(Icons.email)),controller: _usernameController),
      TextFormField(decoration: InputDecoration(labelText: '*Password', prefixIcon: Icon(Icons.vpn_key)),controller: _passwordController,),   
      RaisedButton(onPressed: (){fnSignIn();}, child: Text('Login'),),     
      RaisedButton(onPressed: (){}, child: Text('Sign-up'),),         
    ],)
    );
  } //WIDGET

  //==============================================================================
  // FUNCTION#1: SIGN-IN
  //============================================================================== 
  fnSignIn(){
          _firebaseAuth.signInWithEmailAndPassword(email: _usernameController.text.trim(),password: _passwordController.text.trim()
      ).then((user) {
        logger.i("signed in successed for ${user.user.email}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => AMenuPage(email: _usernameController.text,)),);
      }).catchError((error) {
        logger.e(error);
        showMessageBox(context, "success", "Login error " + error.toString(), actions: [dismissButton(context)]);
        // final snackBar = SnackBar(content: Text(error.toString()),action: SnackBarAction(label: 'Undo',onPressed: () {},),);        
        // Scaffold.of(context).showSnackBar(snackBar);
        });
    }


}//CLASS