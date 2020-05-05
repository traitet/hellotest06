import 'package:flutter/material.dart';

//https://medium.com/flutter-community/flutter-visual-studio-code-shortcuts-for-fast-and-efficient-development-7235bc6c3b7d (HOT KEY)
//https://medium.com/coding-with-flutter/flutter-my-favourite-keyboard-shortcuts-63f6474afc8c (HOT KEY)

class STFWidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: StatefullHomePage(),
    );
  }
}

//================================================
// STF HOMEPAGE
//================================================
class StatefullHomePage extends StatefulWidget {
  @override
  _StatefullHomePageState createState() => _StatefullHomePageState();
}

//================================================
// STF HOMEPAGE (IMPLEMENT)
//================================================
class _StatefullHomePageState extends State<StatefullHomePage> {
//================================================
// 1) DECLARE VARIABLE
//================================================
  final _formkey = GlobalKey<FormState>();
  String _inputQuote;
  String _inputAuthor;
  //================================================
  // DECLARE LIST
  //================================================
  // List<Quote> quotes=[Quote('1111','22222')];
  List<Quote> quotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TEST EP2'),
        ),
        body: Column(
          children: <Widget>[
            Form(
                //================================================
                // ???
                //================================================
                key: _formkey,
                //================================================
                // TEXT
                //================================================
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Quote'),
                      onSaved: (String value) {
                        _inputQuote = value;
                      },
                    ),
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Author'),
                        onSaved: (String value) {
                          _inputAuthor = value;
                        }),
                    RaisedButton(
                      onPressed: () {
                        //================================================
                        // SAVE STATE
                        //================================================
                        _formkey.currentState.save();
                        print(_inputAuthor);
                        print(_inputQuote);
                        //================================================
                        // RELOAD WIDGET
                        //================================================
                        setState(() {
                          quotes.insert(0, Quote(_inputQuote, _inputAuthor));
                        });
                        //================================================
                        // RESET VALUE (TEXTBOX, VALUE)
                        //================================================
                        //quotes.add(Quote(_inputQuote,_inputAuthor));
                        _formkey.currentState.reset();
                      },
                      child: Text("Add"),
                    ),
                  ],
                )),
            Expanded(
              //================================================
              // IF LIST COUNT = 0, SHOW EMPTY OF ANIMATION
              //================================================
              // child: quotes == null
              child: quotes.length == 0
                  ? Center(
                      child:
                          Text('Empty')) //FILL ICON, ANIMATION IF EMPTY (NULL)
                  : ListView.builder(
                      itemCount: quotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return QuoteCard(
                            quotes[index].text, quotes[index].author);
                      },
                    ),
            )
          ],
        )
        // Text('Fear to anger..anger',)
        );
  }
}

class Quote {
  final String text;
  final String author;
  Quote(this.text, this.author);
}

//================================================
// NO USE
//================================================
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TEST EP2'),
        ),
        body: ListView(
          children: <Widget>[
            QuoteCard(
              'a fun project that I had in mind for a while, hope you guys like it! for the original trailer-',
              'Yoda (The Phantom Manace)',
            ),
            QuoteCard(
              'Angular 2: Using the HTTP Service to',
              'Tom Cruist',
            ),
            QuoteCard(
              'Write Data to an API',
              'Json Bacadi',
            ),
          ],
        )
        // Text('Fear to anger..anger',)
        );
  }
}

//================================================
// FUNCTION: SHOW DATA
//================================================
class QuoteCard extends StatelessWidget {
  final String _text;
  final String _author;

  const QuoteCard(this._text, this._author, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
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
