import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hellotest06/main.dart';

//========================================================
// MAIN CLASS
//======================================================== 
class RSplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RSplashScreenState();
  }
}


//========================================================
// STATE CLASS
//======================================================== 

class RSplashScreenState extends State<RSplashScreen> {
  //===============================================================================
  // LOAD SPLASH SCREEN
  //===============================================================================
  @override
  void initState() {
    super.initState();
    loadData();
  }


//========================================================
// BUILD WIDGET
//======================================================== 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/splash2.jpg'),
            fit: BoxFit.cover
        ) ,
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
    );
  }

//====================================================================
// LOAD SPLASH SCREEN
//====================================================================  
Future<Timer> loadData() async {
  return new Timer(Duration(seconds: 5), onDoneLoading);
}
//====================================================================
// ON DID LOAD
//==================================================================== 
onDoneLoading() async {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(title: 'Hello Test 06 - SEEDOO'),));
}


}

