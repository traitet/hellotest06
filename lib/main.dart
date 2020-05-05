import 'package:flutter/material.dart';
import './screens/SetDBFoodMenuPage.dart';
import './screens/CallApiDogPage.dart';
import './screens/CallApiUserPage.dart';
import './screens/Ep2Page.dart';
import './screens/Ep4Page.dart';
import './screens/MySignUpPage.dart';
import './screens/RegisterProductPage.dart';
import './screens/STFWidgetPage.dart';
import './screens/STLWidgetPage.dart';
import './screens/SearchPage.dart';
import './screens/SearchProductPage.dart';
import './screens/SignupPage.dart';
import './screens/StackPage.dart';
import './screens/UploadImagePage.dart';
import './screens/MyResetPasswordPage.dart';
import './screens/MyLoginPage.dart';
// import './screens/ReadQRPage.dart';

//============================================================================
// MAIN APP
//============================================================================
void main() {
  runApp(MyApp());
}

//============================================================================
// MY APP CLASS
//============================================================================
class MyApp extends StatelessWidget {
  //==========================================================================
  // ROOT APP WIDGET
  //==========================================================================
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Test 06 in 2020',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Hello Test 06'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  //==============================================================================
  // PARAMETER: TITLE
  //==============================================================================
  final String title;
  //==============================================================================
  // OVERRIDE CREATE STATE
  //==============================================================================
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//================================================================================
// STF CLASS
//================================================================================
class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //============================================================================
    // SCAFFOLD
    //============================================================================
    return Scaffold(
      //==========================================================================
      // APP BAR
      //==========================================================================
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //==========================================================================
      // BODY
      //==========================================================================
      body: Center(
        //========================================================================
        // CHILD: COLUMN
        //========================================================================
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //====================================================================
            // BUTTON
            //====================================================================  
            //RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DLogininSmsPage()),);}, child: Text('See Doc Login (SMS)'),),   
            // RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DLoginPage()),);}, child: Text('See Doc Login'),),               
            // RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DSignUpPage()),);}, child: Text('See Sign Up'),),  
            // RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DMenuPage(username: 'traitet@',)),);}, child: Text('See Menu Page'),),  
            // RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ReadQRPage()),);}, child: Text('Read QR'),),                          
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CallApiUserPage()),);}, child: Text('Call Api User'),),   
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CallApiDogPage()),);}, child: Text('Call Api Dog'),),             
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => StackPage()),);}, child: Text('Stack Page'),),    
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(username: 'traitet@gmail.com',)),);}, child: Text('Search Page'),),    
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()),);}, child: Text('Signup Page'),),   
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterProductPage()),);}, child: Text('Register Product Page'),),   
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SetDBFoodMenuPage()),);}, child: Text('Register Food Menu Page'),),                                                            
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchProductPage(username: 'traitet@gmail.com',)),);}, child: Text('Search Product Page'),),       
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImagePage()),);}, child: Text('Upload Image 1234'),),         
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MyLoginPage()),);}, child: Text('My Login'),),           
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MySignUpPage()),);}, child: Text('My Sign-up (google)'),),      
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MyResetPasswordPage()),);}, child: Text('My Reset Password (google)'),), 
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Ep2Page()),);}, child: Text('EP2-Layout Stateless'),),    
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Ep4Page()),);}, child: Text('EP4-Statefull & List'),),   
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => STLWidgetPage()),);}, child: Text('Stateless Page'),),   
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => STFWidgetPage()),);}, child: Text('Statefull Widget Page'),), 

            //====================================================================
            // TEXT
            //====================================================================           
            Text('You have pushed the button this many times:',),
          ],
        ),
      ),
    );
  }
}
