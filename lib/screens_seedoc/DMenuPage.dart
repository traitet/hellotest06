import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/screens_seedoc/DUserLoginPage.dart';
import 'package:hellotest06/services/LoggerService.dart';
import '../widgets_seedoc/DCardMenu.dart';
import '../widgets_seedoc/DNavDrawer.dart';

//==============================================================================
// 1) MENU CLASS
//============================================================================== 
class DMenuPage extends StatefulWidget {
    //==========================================================================
    // 1) ARAMETER AND CONSTUCTURE METHOD
    //==========================================================================
    final String email;
    DMenuPage({Key key, @required this.email,})
       : super(key: key); 
  @override
  _DMenuPageState createState() => _DMenuPageState();
}

//==============================================================================
// 2) MENU STATE
//============================================================================== 
class _DMenuPageState extends State<DMenuPage> {
  @override
  Widget build(BuildContext context) {
    //==========================================================================
    // 1) RETURN SCAFFOLD
    //==========================================================================     
    return Scaffold(
      //========================================================================
      // 2) DRAWING
      //========================================================================      
      drawer: DNavDrawer(email: widget.email),      
       //========================================================================
      // 2) APP BAR
      //========================================================================       
      appBar: AppBar(title: Text( widget.email??''),  actions: <Widget>[IconButton(icon: Icon(Icons.exit_to_app), onPressed: fnSignout ),],),
      //========================================================================
      // 3) BODY
      //========================================================================        
      body: DCardMenu(email: widget.email),
            
          );
        }
  //============================================================================
  // 2) FUNCTION SIGN OUT
  //============================================================================    
  void fnSignout() {
  //============================================================================
  // 1) LOGIN BY GOOGLE OR FIREBASE
  //============================================================================
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DUserLoginPage()));    
    logger.i("Sign out complete via firebase and google");

  }
}