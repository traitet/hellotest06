import 'package:flutter/material.dart';
// import '../main.dart';
// import '../screens/LayoutPage.dart';
// import '../screens/LoginPage.dart';
// import '../screens/MenuPage.dart';
import '../screens/MyResetPasswordPage.dart';
import '../screens/MySignUpPage.dart';
// import '../screens/SearchFoodMenuPage.dart';
import '../screens/SearchPage.dart';
// import '../screens/SetDBFoodMenuPage.dart';
import '../screens/SignupPage.dart';
import '../screens/StackPage.dart';

class CardMenu extends StatefulWidget {
  @override
  _CardMenuState createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  @override
    Widget build(BuildContext context) {
//===========================================================
// RETURN CONTAINER AND PUT IN SCAFFOLD IN MENU PAGE
//===========================================================      
    return Container(
     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            //makeDashboardItem(context,"Menu Page", Icons.calendar_today, MaterialPageRoute(builder: (context) => MenuPage(username: 'traitet@gmail.com',))),            
           // makeDashboardItem(context,"Layout Page", Icons.layers,  MaterialPageRoute(builder: (context) => LayoutPage())),     
            makeDashboardItem(context,"Stack Page", Icons.image, MaterialPageRoute(builder: (context) => StackPage())),            
            makeDashboardItem(context,"Search Page", Icons.search, MaterialPageRoute(builder: (context) => SearchPage(username: 'traitet@gmail.com'))),
            makeDashboardItem(context,"Signup Page", Icons.new_releases, MaterialPageRoute(builder: (context) => SignupPage())),
          //  makeDashboardItem(context,"Register Food Menu Page", Icons.supervised_user_circle, MaterialPageRoute(builder: (context) => SetDBFoodMenuPage())),            
            //makeDashboardItem(context,"Search Food Menu Page", Icons.fastfood, MaterialPageRoute(builder: (context) => SearchFoodMenuPage(username: 'traitet@gmail.com',))),     
            //makeDashboardItem(context,"Login", Icons.person, MaterialPageRoute(builder: (context) => LoginPage())),
            makeDashboardItem(context,"My Sign-up (google)", Icons.web, MaterialPageRoute(builder: (context) => MySignUpPage())),
            makeDashboardItem(context,"Reset Password", Icons.vpn_key, MaterialPageRoute(builder: (context) => MyResetPasswordPage())),     
            //makeDashboardItem(context,"Sign-off", Icons.grid_off, MaterialPageRoute(builder: (context) => MyApp())),                          
          ],
        ), 
    );
  }
}

//===========================================================
// 5) FUNCTION TO MAKE DASHBOARD
//===========================================================
  Card makeDashboardItem(BuildContext myContext,String title, IconData icon,  MaterialPageRoute myRoute, ) {
    //=======================================================
    // 1) RETURN CARD
    //=======================================================    
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        //===================================================
        // 2) CHILD: CONTAINER
        //===================================================
        child: Container(
        //=======================================================
        // 3) SIZE
        //=======================================================             
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {Navigator.push(myContext, myRoute);},
            child: Column(
            //=======================================================
            //4) MENU (ICON AND TEXT)
            //=======================================================                 
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                //=======================================================
                // 5) ICON
                //=======================================================                 
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.black,
                    )
                ),
                SizedBox(height: 20.0),
                //=======================================================
                // 5) TEXT
                //=======================================================                   
                Center(
                  child: Text(title,
                      style:
                          TextStyle(fontSize: 16.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }

