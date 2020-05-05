import 'package:flutter/material.dart';

//https://medium.com/flutter-community/flutter-visual-studio-code-shortcuts-for-fast-and-efficient-development-7235bc6c3b7d (HOT KEY)
//https://medium.com/coding-with-flutter/flutter-my-favourite-keyboard-shortcuts-63f6474afc8c (HOT KEY)

class Ep2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TEST EP2'),
        ),
        body: ListView(
          children: <Widget>[
            StartWallWidget(
                'a fun project that I had in mind for a while, hope you guys like it! for the original trailer-',
                'Yoda (The Phantom Manace)',
                'https://m.media-amazon.com/images/I/61cwJtk2bIL._SS500_.jpg'),
            StartWallWidget(
                'Angular 2: Using the HTTP Service to',
                'Tom Cruist',
                'https://thewdwplanner.com/wp-content/uploads/2017/01/Starwards-Day-At-Sea.png'),
            StartWallWidget('Write Data to an API', 'Json Bacadi',
                'https://www.starwards.org.uk/wp-content/uploads/2017/05/starwards_logo_print.jpg'),
          ],
        )
        // Text('Fear to anger..anger',)
        );
  }
}

class StartWallWidget extends StatelessWidget {
  final String _text;
  final String _author;
  final String _imageUrl;
  const StartWallWidget(this._text, this._author, this._imageUrl, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(image: NetworkImage(_imageUrl))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment(1, 0),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _author,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                //fontSize: 20,
              ), // Text style
            ), // Text
          ) // Container
        ],
      ),
    );
  } // Widget
} // Class
