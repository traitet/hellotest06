
//==========================================================================
// IMPORT
//==========================================================================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//==========================================================================
// MAIN CLASS
//==========================================================================
class DDocApprovePage extends StatefulWidget {
  @override
  _DDocApprovePageState createState() => _DDocApprovePageState();
}

//==========================================================================
// STATE CLASS
//==========================================================================
class _DDocApprovePageState extends State<DDocApprovePage> {
//==========================================================================
// CONSTUCTURE
//==========================================================================  
  int _bottmTabIndex = 0;
//==========================================================================
// DECLARE VARIABLE
//==========================================================================  
  @override
  Widget build(BuildContext context) {
//==========================================================================
// RETURN MAT APP
//==========================================================================    
    return DefaultTabController(
      length: choices.length,
      child: MaterialApp(
//==========================================================================
// SHOW DEBUG
//==========================================================================      
        debugShowCheckedModeBanner: false,         
//==========================================================================
// THEME
//==========================================================================
        theme: ThemeData(primarySwatch: Theme.of(context).primaryColor,),    
//==========================================================================
// HOME
//==========================================================================          
        home: Scaffold(
//==========================================================================
// APP BAR
//==========================================================================            
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){Navigator.pop(context);}),       
            actions: <Widget>[IconButton(onPressed: (){},icon: Icon(Icons.control_point),)],   
            title: Text('Approve Doc'), 
//==========================================================================
// BOTTOM APP BAR
//==========================================================================
            bottom: TabBar(
              isScrollable: false,
              onTap: (int index){setState(() {

              });},
              tabs: choices.map((e) {return Tab(text: e.title, icon: Icon(e.icon),);}).toList(),
            )           
          ),
//==========================================================================
// BOTTOM NAVIGATION BAR
//==========================================================================         
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){setState(() {_bottmTabIndex = index;});},
            type: BottomNavigationBarType.fixed,
            currentIndex: _bottmTabIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),title:Text('Home')),
              BottomNavigationBarItem(icon: Icon(Icons.track_changes),title:Text('Tasks')),         
              BottomNavigationBarItem(icon: Icon(Icons.search),title:Text('Search')),    
              BottomNavigationBarItem(icon: Icon(Icons.more_horiz),title:Text('More')),                               
            ],
          ),
//==========================================================================
// BODY
//==========================================================================             
            body: TabBarView(children: <Widget>[
              tab1(),
              tab1(),
              tab1(),              
            ],
            ),   
        ),
      ),
    );
  }
}

//==========================================================================
// TAB#1
//==========================================================================
tab1(){ return
        ListView(children: <Widget>[
          BodyWidget(),
          BodyWidget(),
          BodyWidget(),
          BodyWidget(),
          BodyWidget(),                                
        ]); 

}

//==========================================================================
// BODY WIDGET
//==========================================================================
class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
//==========================================================================
// IMAGE
//==========================================================================                
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/nueng.png'))
                ),
              ),
              SizedBox(width: 10,),
//==========================================================================
// DETAIL
//==========================================================================                    
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Peak : Holiday Leave',style: TextStyle(fontSize: 16,color: Colors.black)),
                    Text('From: Somchai Knamsang/Toyota',style: TextStyle(fontSize: 14,color: Colors.grey)),
                    Text('Mon, 26 Oct at 03:30',style: TextStyle(fontSize: 14,color: Colors.grey)),
                    SizedBox(height: 5,)
                  ],
                ),
              ),
//==========================================================================
// SYMBOL >
//==========================================================================  
                Icon(Icons.chevron_right,color: Colors.grey,)
            ],),
//==========================================================================
// BOTTOM ROW
//==========================================================================            
                Row(
                  children: <Widget>[
                    Expanded(child: RaisedButton(child: Text('Accept'),onPressed: (){},)),
                    SizedBox(width: 10,),
                    Expanded(child: RaisedButton(child: Text('Maybe'),onPressed: (){},)) ,
                    SizedBox(width: 10,),                    
                    Expanded(child: RaisedButton(child: Text('Decline'),onPressed: (){},))                      
                  ],
                ),
//==========================================================================
// END COLUMN
//==========================================================================                                 
          ],
        ),
      ),
    );
  }
}


//==========================================================================
// CLASS CHOICE
//==========================================================================
class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}
//==========================================================================
// LIST
//==========================================================================
const List<Choice> choices = const <Choice>[
  const Choice(title: 'New (1)', icon: Icons.check_circle_outline),
  const Choice(title: 'Replied (5)', icon: Icons.reply_all),
  const Choice(title: 'All (200)', icon: Icons.all_inclusive),  
];


