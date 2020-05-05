import 'package:flutter/material.dart';
import '../services/DogService.dart';
import '../models/DogModel.dart';

class CallApiDogPage extends StatefulWidget {
  @override
  _CallApiPageDogState createState() => _CallApiPageDogState();
}

class _CallApiPageDogState extends State<CallApiDogPage> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CALL API: RANDOM DOG"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                  future: DogService.randomDog(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DogModel msg = snapshot.data;
                      print("snap = "+msg.message);
                      return Image.network(msg.message,width: 300,height: 200,);
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ));
  }






  
}




