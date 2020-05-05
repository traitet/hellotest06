import 'package:flutter/material.dart';

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      //============================================================
      // SCAFFOLD = APP BAR + BODY
      //============================================================      
      appBar: AppBar(title: Text('Layout Page'),),
      body: 
        SafeArea(child: ListView(
          children: <Widget>[
              Text('2.row 1'), 
              Column(
                  children: <Widget>[
                          Text('2.row 1=============>'),   
                          Text('2.row 2=============>'),  
                          Text('2.row 3===========sdfsafasfasf==>'),   
                          RaisedButton(onPressed: (){}, child: Text('abc'),),       
                          TextFormField(decoration: InputDecoration(labelText: 'company', prefixIcon: Icon(Icons.home)),),    
                          TextFormField(decoration: InputDecoration(labelText: 'name', prefixIcon: Icon(Icons.nature)),),                                                                                                               
                  ],
              ),  
            //============================================================
            // 1) space
            //============================================================             
            SizedBox(height: 30), //SPACE
            //============================================================
            // 2) row
            //============================================================                  
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Expanded(child: Container(height: 50, color: Colors.red,)),
                Expanded(child: Container(height: 50, color: Colors.green,)),                
                // Text('2.row 1'),
                // Text('2.row 2'),
                // Text('2.row 3'),     
              ],
            ),
            //============================================================
            // 3) space
            //============================================================                  
            SizedBox(height: 20),   //SPACE
            //============================================================
            // 4) row
            //============================================================                  
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Expanded(child: Text('4.row# 1.21434214'),),
                Expanded(child: Text('4.row# 2.214124124'),),  
                Expanded(child: Text('4. row# 3.fsa'),),                                                            
              ]
            ),  
            //============================================================
            // 5) space
            //============================================================      
             SizedBox(height: 20),    
            //============================================================
            // 6) Column
            //============================================================                           
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,              
              children: <Widget>[
                Text('6. Column 1'),
                Text('6. Column 2'),
                Text('6. Column 3'),                
              ]
            ), 
            //============================================================
            // 5) space
            //============================================================      
             SizedBox(height: 20),              
            //============================================================
            // 6) Column
            // NOTE: Container -> Child has Colummn or Row -> Children -> Containers
            //============================================================                           
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,              
              children: <Widget>[
                Container(
                  color: Colors.yellow,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Text('This is column row1'),
                      Text('This is column row2'),
                      Text('This is column row3'),    
                      Container(
                        color: Colors.red,
                         padding: EdgeInsets.all(15.0),
                         child: Row(children: [
                          Expanded(child: Text('Row 1/1', style: TextStyle(color: Colors.white),)),
                          Expanded(child: Text('Row 1/2', style: TextStyle(color: Colors.yellow))),
                          Expanded(child: Text('Row 3/3', style: TextStyle(color: Colors.black26))),                                                   
                         ],),
                      )
                    ],
                  ),
                ),
                Text('7. Column 4'),
                Text('8. Column 5'),
                Text('9. Column 6'),                
              ]
            ), 

          ],
          ),      
        )
    );
  }
}