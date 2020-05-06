import 'package:flutter/material.dart';
// import '../screens/FlutterImagePickerPage.dart';
import '../screens/SetDBFoodMenuPage.dart';
import '../screens/UploadImagePage.dart';
import '../screens_seedoc/DDocViewPage.dart';
import '../screens_seedoc/DDocSearchPage.dart';
import '../screens_seedoc/DDocCreatePage.dart';
import '../screens_seedoc/DDocWfSettingPage.dart';
import '../screens_seedoc/DLoginPage.dart';
import '../screens_seedoc/DEditProfilePage.dart';

class DCardMenu extends StatefulWidget {
  @override
  _DCardMenuState createState() => _DCardMenuState();
}


class _DCardMenuState extends State<DCardMenu> {
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
            BuildCardButtons(myIcon: Icons.book,myText: "Create Document",myNavigateText: "DDocCreatePage",),
            BuildCardButtons(myIcon: Icons.settings,myText: "Setting Doc Workflow ",myNavigateText: "DDocWfSettingPage",),  
            // BuildCardButtons(myIcon: Icons.videocam,myText: "Flutter Image Picker",myNavigateText: "FlutterImagePickerPage",),   
            BuildCardButtons(myIcon: Icons.cloud_upload,myText: "Upload Image",myNavigateText: "UploadImagePage",),   
            BuildCardButtons(myIcon: Icons.file_upload,myText: "Upload Image and Menu",myNavigateText: "SetDBFoodMenuPage",),   
            BuildCardButtons(myIcon: Icons.settings,myText: "Doc Flow Setup",myNavigateText: "DDocWfSettingPage",),  
            BuildCardButtons(myIcon: Icons.view_list,myText: "View Document",myNavigateText: "DDocViewPage",),  
            BuildCardButtons(myIcon: Icons.view_list,myText: "Search Document",myNavigateText: "DDocSearchPage",),     
            BuildCardButtons(myIcon: Icons.verified_user,myText: "Profile",myNavigateText: "DEditProfilePage",),  
            BuildCardButtons(myIcon: Icons.exit_to_app,myText: "Login",myNavigateText: "DLoginPage",),  
        ],
      ),
    );
  }
}

class BuildRaiseButton extends StatelessWidget {
  const BuildRaiseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocCreatePage()),);}, child: Text('Call Api Dog'),);
  }
}

class BuildCardButton extends StatelessWidget {
  const BuildCardButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Card(
      child: InkWell(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocCreatePage()),);},
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
  //final MaterialPageRoute myMaterialPageRoute;
  const BuildCardButtons({
    Key key, 
    this.myIcon, 
    this.myText, 
    this.myNavigateText,
    //this.myMaterialPageRoute,
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
            if (myNavigateText=="DDocCreatePage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocCreatePage()));}
            if (myNavigateText=="DDocWfSettingPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocWfSettingPage(docid: "",)));}            
            // if (myNavigateText=="FlutterImagePickerPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => FlutterImagePickerPage(context);}  
            if (myNavigateText=="UploadImagePage"){Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImagePage()));}  
            if (myNavigateText=="SetDBFoodMenuPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => SetDBFoodMenuPage()));}  
            if (myNavigateText=="DDocViewPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocViewPage(docid: "")));}  
            if (myNavigateText=="DDocSearchPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DDocSearchPage(docid: "",)));}  
            if (myNavigateText=="DEditProfilePage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DEditProfilePage()));}  
            if (myNavigateText=="DLoginPage"){Navigator.push(context, MaterialPageRoute(builder: (context) => DLoginPage()));}                                                              
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


