import 'package:flutter/material.dart';
import '../widgets/CardMenu.dart';
import '../widgets/NavDrawer.dart';

class MenuPage extends StatefulWidget {
    //=======================================================
    // 1) ARAMETER AND CONSTUCTURE METHOD
    //=======================================================
    final String username;
    MenuPage({Key key, @required this.username,})
    
      : super(key: key);    
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),      
      appBar: AppBar(title: Text('Menu Page: ' + widget.username),),
      body: CardMenu(),
      
    );
  }
}