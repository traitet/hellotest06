import 'package:flutter/material.dart';
import 'package:hellotest06/screens_seeapprove/AMenuPage.dart';

class ALoginPage extends StatefulWidget {
  @override
  _ALoginPageState createState() => _ALoginPageState();
}

class _ALoginPageState extends State<ALoginPage> {
      final _usernameController = TextEditingController()..text = 'traitet@gmail.com';  
      final _passwordController = TextEditingController()..text = 'password';      
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Login'),),
    body: Column(children: <Widget>[
      TextFormField(decoration: InputDecoration(labelText: '*E-mail', prefixIcon: Icon(Icons.email)),controller: _usernameController),
      TextFormField(decoration: InputDecoration(labelText: '*Password', prefixIcon: Icon(Icons.vpn_key)),controller: _passwordController,),   
      RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AMenuPage(email: _usernameController.text,)),);}, child: Text('Login'),),     

    ],)

    );
      
    
  }
}