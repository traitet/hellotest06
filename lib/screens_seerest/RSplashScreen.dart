import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
  }

//========================================================
// BUILD WIDGET
//======================================================== 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/splash1.jpg'),
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
}