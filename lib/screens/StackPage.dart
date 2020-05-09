import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  @override
  _StackPageState createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Page'),),
  body:SafeArea(
        //============================================================================
        // STACK ( OR COLUMN, ROW) --> STACK = OVERLAY (ซ้อนกัน)
        //============================================================================        
        child: Stack(
          children: <Widget>[
        //============================================================================
        // CONTAINER (1) SHOW IMAGE IN CONTAINER (FULL SCREEN)
        //============================================================================              
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://cdn.mos.cms.futurecdn.net/3tcJXLkZ8Sk9cPpLquFTWV.jpg'),
                  fit: BoxFit.cover,
                )
              ),
              child: null),
        //============================================================================
        // CENTER (2) SHOW TEXT (BUTTOM OM PAGE)
        //============================================================================           
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Text('FINAL FANTASY VII: README TEST TEST TEST',
                      style: TextStyle(color: Colors.white,fontSize: 15,),
                    )
                  )
                ],
              ),
            )
            //)
          ],
        ),
      )
    );
  }
}