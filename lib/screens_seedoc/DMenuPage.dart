import 'package:flutter/material.dart';
import '../widgets_seedoc/DCardMenu.dart';
import '../widgets_seedoc/DNavDrawer.dart';


class DMenuPage extends StatefulWidget {
    //=======================================================
    // 1) ARAMETER AND CONSTUCTURE METHOD
    //=======================================================
    final String username;
    DMenuPage({Key key, @required this.username,})
    
      : super(key: key); 

      
         
  @override
  _DMenuPageState createState() => _DMenuPageState();
}

class _DMenuPageState extends State<DMenuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DNavDrawer(),      
      appBar: AppBar(title: Text( widget.username??''),),
      body: DCardMenu(),
      
    );
  }
}