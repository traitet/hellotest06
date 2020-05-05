import 'package:flutter/material.dart';

class STLWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateless Widget"),
      ),
      body: ListView(
        children: [
          Starwar('test1  การหฟกดฟหดฟหด','test2','https://m.media-amazon.com/images/I/61cwJtk2bIL._SS500_.jpg'),
          Starwar('test1','test2','https://thewdwplanner.com/wp-content/uploads/2017/01/Starwards-Day-At-Sea.png'),
          Starwar('test1','test2','https://www.starwards.org.uk/wp-content/uploads/2017/05/starwards_logo_print.jpg'),
          // Text("test this is a book"),
          // Text("Jin Thomson")
        ],
      ),
    );
  }
}

class Starwar extends StatelessWidget {
  final String _text1;
  final String _text2;
  final String _imageUrl;

  const Starwar(
    this._text1,this._text2,this._imageUrl,
    {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(
                          _imageUrl)))),
        ),
        Text(_text1, style: TextStyle(fontSize: 20),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment(1, 0),
            child: Text(_text2, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10,),)),
        ),
      ],
    );
  }
}
