import 'package:flutter/material.dart';
// import '../screens/FlutterImagePickerPage.dart';
import '../screens/SetDBFoodMenuPage.dart';
import '../screens/UploadImagePage.dart';
import '../screens_seedoc/DDocViewPage.dart';
import '../screens_seedoc/DDocSearchPage.dart';
import '../screens_seedoc/DDocNewPage.dart';
import '../screens_seedoc/DDocWfSettingPage.dart';
import '../screens_seedoc/DUserLoginPage.dart';
import '../screens_seedoc/DUserEditPage.dart';

class DCardMenu extends StatefulWidget {
  //========================================================================================
  // DECLARE PARAMETER
  //========================================================================================
  final String email;
  DCardMenu({Key key, @required this.email}) : super(key: key);  
  @override
  _DCardMenuState createState() => _DCardMenuState();
}


class _DCardMenuState extends State<DCardMenu> {
  // final String _username; 
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
            BuildCardButtons(myIcon: Icons.book,myText: "Create Document",myNavigateText: "DDocNewPage",myEmail: widget.email,),
            BuildCardButtons(myIcon: Icons.view_list,myText: "Search Document",myNavigateText: "DDocSearchPage",myEmail: widget.email),   
            BuildCardButtons(myIcon: Icons.view_list,myText: "View Document",myNavigateText: "DDocViewPage",myEmail: widget.email),
            BuildCardButtons(myIcon: Icons.verified_user,myText: "Profile",myNavigateText: "DUserEditPage",myEmail: widget.email),                                        
            BuildCardButtons(myIcon: Icons.settings,myText: "Setting Doc Workflow ",myNavigateText: "DDocWfSettingPage",myEmail: widget.email),  
            BuildCardButtons(myIcon: Icons.cloud_upload,myText: "Upload Image",myNavigateText: "UploadImagePage",myEmail: widget.email),   
            BuildCardButtons(myIcon: Icons.file_upload,myText: "Upload Image and Menu",myNavigateText: "SetDBFoodMenuPage",myEmail: widget.email),   
            BuildCardButtons(myIcon: Icons.exit_to_app,myText: "Login",myNavigateText: "DUserLoginPage",myEmail: widget.email),  
        ],
      ),
    );
  }
}

// class BuildRaiseButton extends StatelessWidget {
//   const BuildRaiseButton({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocNewPage(email: 'traitet@gmail.com',)),);}, child: Text('Call Api Dog'),);
//   }
// }

//==============================================================
// SUB FUNCTION: BUILD CARD BUTTON
//==============================================================
class BuildCardButton extends StatelessWidget {
  final String myEmail; 
  const BuildCardButton({
    Key key,this.myEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,) {
    return 
    Card(
      child: InkWell(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocNewPage(email: myEmail,)),);},
        child: Column(children: <Widget>[
          Icon(Icons.access_alarm),
          Text("Create Document"),
        ],),
      )
      );
  }}


//==============================================================
// CLOUD CARD BUTTONS
//==============================================================
class BuildCardButtons extends StatelessWidget {
  final IconData myIcon;
  final String myText;
  final String myNavigateText;
  final String myEmail;
  const BuildCardButtons({
    Key key, 
    this.myIcon, 
    this.myText, 
    this.myNavigateText,
    this.myEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
  Card(
      elevation: 1.0,
      margin: new EdgeInsets.all(8.0),
      //==============================================================
      // 2) CHILD: CONTAINER
      //==============================================================
      child: Container(
        //============================================================
        // 3) SIZE
        //============================================================
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: new InkWell(
          onTap: () {
            if (myNavigateText=="DDocNewPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocNewPage(email:myEmail,)));}
            if (myNavigateText=="DDocWfSettingPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocWfSettingPage(docid: "D2000017|1588776824675",)));}            
            // if (myNavigateText=="FlutterImagePickerPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => FlutterImagePickerPage(context);}  
            if (myNavigateText=="UploadImagePage"){Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImagePage()));}  
            if (myNavigateText=="SetDBFoodMenuPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => SetDBFoodMenuPage()));}  
            if (myNavigateText=="DDocViewPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocViewPage(docid: "D2000017|1588776824675")));}  
            if (myNavigateText=="DDocSearchPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocSearchPage(email: myEmail ,)));}  
            if (myNavigateText=="DUserEditPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DUserEditPage(email: myEmail)));}  
            if (myNavigateText=="DUserLoginPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DUserLoginPage()));}                                                              
          },
          child: Column(
            //========================================================
            //4) MENU (ICON AND TEXT)
            //========================================================
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
                myIcon,
                size: 40.0,
                color: Colors.black,
              )),
              SizedBox(height: 20.0),
              //=======================================================
              // 5) TEXT
              //=======================================================
              Center(
                child: Text(myText,
                    style: TextStyle(fontSize: 16.0, color: Colors.black)),
              )
            ],
          ),
        ),
      ));
  }}


