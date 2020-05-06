import 'package:flutter/material.dart';
import '../screens_seedoc/DDocSearchPage.dart';
import '../screens_seedoc/DDocViewPage.dart';
import '../screens_seedoc/DDocCreatePage.dart';
import '../screens_seedoc/DLoginPage.dart';
import '../screens_seedoc/DDocWfSettingPage.dart';
import '../screens_seedoc/DEditProfilePage.dart';

import '../services_seedoc/DFirebaseAuth.dart' as MyFirebaseAuthen;
// import '../services_seedoc/DFirebaseAuthFB.dart' as MyFirebaseAuthenFB;

//============================================================================
// DECLARE VARIABLE
//============================================================================
// final FirebaseAuth _auth = FirebaseAuth.instance;

class DNavDrawer extends StatefulWidget {
  @override
  _DNavDrawerState createState() => _DNavDrawerState();
}

class _DNavDrawerState extends State<DNavDrawer> {
  @override
  Widget build(BuildContext context) {
    //=========================================================
    // 1) RETURN DRAWER WIDGET
    //=========================================================
    return Drawer(
      //=======================================================
      // 2) DATA IN DRAWER IS CHILD: LISTVIEW()
      //=======================================================
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //===================================================
          // 3) FILL HEADER NAME
          //===================================================
          DrawerHeader(
            child: Text("Main Menu"),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bg01.jpg'))),
          ),
          //===================================================
          // 4) LIST TILE
          //===================================================
          BuildListTile(
              "Create Document",
              MaterialPageRoute(builder: (context) => DDocCreatePage()),
              Icon(Icons.book)),
          BuildListTile(
              "Doc Flow Setup",
              MaterialPageRoute(builder: (context) => DDocWfSettingPage(docid: "",)),
              Icon(Icons.settings)),              
          BuildListTile(
              "View Document",
              MaterialPageRoute(builder: (context) => DDocViewPage(docid: "",)),
              Icon(Icons.view_list)),
          BuildListTile(
              "Search Document",
              MaterialPageRoute(builder: (context) => DDocSearchPage(docid: "",)),
              Icon(Icons.search)),
          BuildListTile(
              "Profile",
              MaterialPageRoute(builder: (context) => DEditProfilePage()),
              Icon(Icons.verified_user)),
          BuildListTileLogout(
              "Logout",
              MaterialPageRoute(builder: (context) => DLoginPage()),
              Icon(Icons.exit_to_app)),
        ],
      ),
    );
  } // WIDGET
}

//==============================================================
// BUILD STATELESS WIDGET
//==============================================================
class BuildListTile extends StatelessWidget {
  //============================================================
  // DECLARE PARAMETER
  //============================================================  
  final String _title;
  final MaterialPageRoute _materialPageRoute;
  final Icon _icon;
  //============================================================
  // CONSTRUCTURE
  //============================================================  
    const BuildListTile(
    this._title,
    this._materialPageRoute,
    this._icon, {
    Key key,
  }) : super(key: key);

  @override
  //============================================================
  // RETURN WIDGET
  //============================================================
  Widget build(BuildContext context) {
    return ListTile(
      leading: _icon,
      title: Text(_title),
      onTap: () => {
        Navigator.push(
          context,
          _materialPageRoute,
        )
      },
    );
  }
} // CLASS


//==============================================================
// BUILD STATELESS WIDGET
//==============================================================
class BuildListTileLogout extends StatelessWidget {
  //============================================================
  // DECLARE PARAMETER
  //============================================================  
  final String _title;
  final MaterialPageRoute _materialPageRoute;
  final Icon _icon;
  //============================================================
  // CONSTRUCTURE
  //============================================================  
    const BuildListTileLogout(
    this._title,
    this._materialPageRoute,
    this._icon, {
    Key key,
  }) : super(key: key);

  @override
  //============================================================
  // RETURN WIDGET
  //============================================================
  Widget build(BuildContext context) {
    return ListTile(
      leading: _icon,
      title: Text(_title),
      onTap: () => {

        MyFirebaseAuthen.signOutGoogle(),
        Navigator.push(
          context,
          _materialPageRoute,
        )
      },
    );
  }
}