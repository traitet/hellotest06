import 'package:flutter/material.dart';
import 'package:hellotest06/screens_seeapprove/ALoginPage.dart';
import 'package:hellotest06/screens_seerest/RSplashScreen.dart';
import 'package:image_picker/image_picker.dart';
import './screens_seerest/RMenuNewPage.dart';
import './screens_seerest/RMenuViewPage.dart';
import './screens_seerest/RMenuSearchPage.dart';
import './screens_seerest/RMenuCatNewPage.dart';
import './sceens_seetutorial/CFriendChatPage.dart';
import './screens_seedoc/DDocNewPage.dart';
import './screens_seedoc/DDocSearchPage.dart';
import './screens_seedoc/DDocViewPage.dart';
import './screens_seedoc/DUserLoginPage.dart';
import './screens_seedoc/DUserNewPage.dart';
import './screens/LayoutPage.dart';
import './screens/MenuPage.dart';
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

//=================================================================================
// MY APP CLASS
//=================================================================================
class MyApp extends StatelessWidget {
  //===============================================================================
  // ROOT APP WIDGET
  //===============================================================================
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Test 06 in 2020',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RSplashScreen(), 
      //MyHomePage(title: 'Hello Test 06 - UPDATED'),
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

//=================================================================================
// STF CLASS
//=================================================================================
class _MyHomePageState extends State<MyHomePage> {
 //===============================================================================
  // BUILD WIDGET
  //===============================================================================
  @override
  Widget build(BuildContext context) {
    //=============================================================================
    // SCAFFOLD
    //=============================================================================
    return Scaffold(
      //===========================================================================
      // APP BAR
      //===========================================================================
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //===========================================================================
      // BODY
      //===========================================================================
      body: Center(
        //=========================================================================
        // CHILD: COLUMN
        //=========================================================================
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //=====================================================================
            // TEXT
            //=====================================================================           
            Text('CHECK HOT RELOAD'),            
            //====================================================================
            // BUTTON
            //====================================================================  
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ALoginPage()),);}, child: Text('A E-document: Login'),),               
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RMenuViewPage(menuId: "M0001",)),);}, child: Text('Rest: View Food Menu'),),    
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RMenuSearchPage()),);}, child: Text('Rest: Search Food Menu'),),                            
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RMenuNewPage()),);}, child: Text('Rest: New Menu'),),  
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RMenuCatNewPage()),);}, child: Text('Rest: New Menu Category'),),                             
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CFriendChatPage()),);}, child: Text('See Chat App'),),                  
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DUserLoginPage()),);}, child: Text('See Doc Login'),),              
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DUserNewPage()),);}, child: Text('D-Sign up'),),              
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocSearchPage(email: "traitet@gmail.com",)),);}, child: Text('D-Search -traitet'),),      
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocSearchPage(email: "satit_po@gmail.com",)),);}, child: Text('D-Search -satit'),),                                                   
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocNewPage(email: 'traitet@gmail.com',)),);}, child: Text('D-Create Document'),),                
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocViewPage(docid: 'D2000004|1588756759854',)),);}, child: Text('D-View Document'),),            
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CallApiUserPage()),);}, child: Text('Call Api User'),),   
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CallApiDogPage()),);}, child: Text('Call Api Dog'),),  
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(username: 'traitet@gmail.com',)),);}, child: Text('Menu Page'),),
            RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LayoutPage()),);}, child: Text('Layout Page'),),                         
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
            RaisedButton(child: Text('Choose File'),onPressed: chooseFile,   color: Colors.cyan,),
            
            //RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DLogininSmsPage()),);}, child: Text('See Doc Login (SMS)'),),    
            // RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DUserNewPage()),);}, child: Text('See Sign Up'),),  
            // RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DMenuPage(username: 'traitet@',)),);}, child: Text('See Menu Page'),),  
            // RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ReadQRPage()),);}, child: Text('Read QR'),),  
            // RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocNewPage()),);}, child: Text('Call Api User'),),             



          ],
        ),
      ),
    );
  }





}



Future chooseFile() async {    
   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
    //  setState(() {    
    //    _image = image;    
    //  });    
   });    
 }  


 