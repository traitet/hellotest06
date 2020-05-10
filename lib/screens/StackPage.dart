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
                  //image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/hellotest06-88fae.appspot.com/o/chats%2Fimage_picker2667190986017541656.jpg%7D?alt=media&token=df74f51a-de37-432f-bced-758e8f621e68'),                  
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