//========================================================
// IMPORT
// REF: NAV BAR: https://www.androidthai.in.th/android-flutter/389-bottom-navigation-bar-on-flutter.html
//========================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/models_seerest/RMenuCatModel.dart';
// import 'package:flutter_counter/flutter_counter.dart';
import 'package:hellotest06/models_seerest/RMenuModel.dart';
import 'package:hellotest06/screens_seerest/ROrderPage..dart';
import 'package:hellotest06/widgets/BadgeIcon.dart';
import '../screens_seerest/RMenuViewPage.dart';
import '../models_seerest/ROrderModel.dart';
import '../services/LoggerService.dart';

//==========================================================
// MAIN CLASS
//==========================================================  
class RMenuSearchPage extends StatefulWidget {
  @override
  _RMenuSearchPageState createState() => _RMenuSearchPageState();
}

//==========================================================
// STATE CLASS
//==========================================================================================  
class _RMenuSearchPageState extends State<RMenuSearchPage> {
  //========================================================================================
  // DECLARE VARIABLE
  //======================================================================================== 
  int index = 0;
  int _orderItemCount = 0;  
  String _menuCategory = 'Main';
  // Map<String, int> _counterArr = {};  

  //========================================================================================
  // OVERRIDE
  //========================================================================================   
  @override
  //========================================================================================
  // 3) INIT: GET DATA FROM DB
  //========================================================================================
  void initState() {
    super.initState();
    Firestore.instance.collection('TT_ORDER').getDocuments().then((myDocuments) {
      //====================================================================================
      // 3.1) AFTER GET DATA
      //====================================================================================
      setState(() {
        //==================================================================================
        // 1) NOT FOUND IN DB
        //==================================================================================          
          logger.i(myDocuments.documents.length.toString());
          _orderItemCount = myDocuments.documents.length;
      });
    });}

  //========================================================================================
  // BUILD UI
  //======================================================================================== 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //====================================================================================
      // APP BAR:      
      //====================================================================================       
      appBar: AppBar(
        title: Text('Menu Search'),       
        actions: <Widget>[IconButton(
            icon: StreamBuilder(
            initialData: _orderItemCount,
            stream:  Firestore.instance.collection("TT_ORDER").snapshots(),
            builder: (BuildContext context, AsyncSnapshot _shapshot) => BadgeIcon(icon:Icon(Icons.add_shopping_cart, size: 25,),
            badgeCount:  _shapshot.data.documents.length??0        
        ), )
        , onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ROrderPage()),);}     ),],
      ),
      //====================================================================================
      // BUTTOM NAVIGATOR
      //====================================================================================       
      bottomNavigationBar: myBottomNavBar(),
      //====================================================================================
      // BODY
      //====================================================================================       
      body: ListView(
        children: <Widget>[
          Container(
            height: 90,
            child: StreamBuilder(
              stream: Firestore.instance.collection("TM_REST_MENU_CAT").snapshots(),
              builder:(context, snapshot) {
                if (!snapshot.hasData){return Center(child: Column(children: <Widget>[CircularProgressIndicator(),Text('Loading...') ],),);}
                else{
                  return ListView.builder(
                     scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){  
                      //==========================================================================
                      // GET DATA
                      //========================================================================== 
                      var _model = RMenuCatModel.fromFilestore(snapshot.data.documents[index]); 
                      //==========================================================================
                      // FILL DATA
                      //==========================================================================                 
                      String _docId = snapshot.data.documents[index].documentID;              
                      String _name =  _model.name ;   
                      logger.i(_model.toFileStone().toString);    
                      String _imageUrl =  _model.imageUrl;     
                      return Card(  child: Container(child: InkWell(
                          onTap: () { setState(() {
                             _menuCategory = _name;
                          });},                   
                          child: Column(children: <Widget>[widgetMenuCat(_name,_imageUrl,_docId),],),),),);
                    }, //itemBuilder                                               
                  ); 
                }}
            )
          ),
            
            
          Container(
            height: 500,
            child: StreamBuilder(
              //==================================================================================
              // GET DATA FROM DB
              //==================================================================================         
              stream: Firestore.instance.collection("TM_REST_MENU").where('menuCategory', isEqualTo: _menuCategory).snapshots(),
              //==================================================================================
              // BUILDER
              //==================================================================================          
              builder:(context, snapshot) {
                 if (!snapshot.hasData){return Center(child: Column(children: <Widget>[CircularProgressIndicator(),Text('Loading...') ],),);}
                 else
                 {

                  return ListView.builder(
                    //============================================================================
                    // 1) DECLARE VARIABLE
                    //============================================================================                 
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      //==========================================================================
                      // GET DATA
                      //========================================================================== 
                      var _model = RMenuModel.fromFilestore(snapshot.data.documents[index]); 
                      //==========================================================================
                      // FILL DATA
                      //==========================================================================                 
                      String _docId = snapshot.data.documents[index].documentID;              
                      String _name =  _model.name ;  
                      String _description =  _model.description;  
                      double _price =  _model.price??100;     
                      String _imageUrl =  _model.imageUrl??'';                                      
                    return Padding(padding: const EdgeInsets.all(8.0),
                        //========================================================================
                        // CARD AT EACH INDEX
                        //========================================================================                  
                        child: Card(  child: Container(child: InkWell(
                          onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => RMenuViewPage(menuId: snapshot.data.documents[index].documentID,)));},                   
                          child: Column(children: <Widget>[
                            widgetBodyText(_docId,_name,_description,_price,_imageUrl), 
                          ],),),),));
                    }, //itemBuilder
                  );
                 } //Else
               } // Builder
            ),
          ),
        ],
      )
    );
  }

  //========================================================================================
  // WIDGET: BODY TEXT
  //========================================================================================
  Widget widgetMenuCat(String myText,String myImageUrl,  String myMenuCatId,) {
    return Container(height: 80,width: 80,child: Stack(children: <Widget>[
      Container(width: 90,),//child: Image.asset('assets/images/bg01.jpg',fit: BoxFit.cover,),
      Container(alignment: Alignment.center,color:  Colors.grey,child: Text(myText)),
     // Center(child: Icon(myIcon,size: 40.0,color: Colors.black,)),
    ],),
    );}

  //========================================================================================
  // WIDGET: BODY TEXT
  //========================================================================================
  Widget widgetBodyText(String myMenuId,String myName, String myDescription, double myPrice, String imageUrl)  { 
  return 
    //======================================================================================
    // CONTAINER
    //======================================================================================
    Container(
      child: Padding(padding: const EdgeInsets.all(8),
        //==================================================================================
        // CHILD/CHILDREN PROPERTY
        //==================================================================================
        child: Row(children: [
          //================================================================================
          // SHOW IMAGE
          //================================================================================
          imageUrl != '' ? Container(padding: const EdgeInsets.only(right: 8),
            width: 100, child: Image.network(imageUrl))
            : Padding(padding: const EdgeInsets.all(4.0),child: Container(width: 100,child: Image.asset('assets/images/bg01.jpg'),),),
          Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                      Padding(padding: const EdgeInsets.only(bottom: 2), child: Container(child: Text(myMenuId,style: TextStyle(fontWeight: FontWeight.bold,),),),),                      
                      Padding(padding: const EdgeInsets.only(bottom: 2), child: Container(child: Text(myName,style: TextStyle(fontWeight: FontWeight.bold,),),),),
                      Padding(padding: const EdgeInsets.only(bottom: 2), child: Container(child: Text(myDescription,style: TextStyle(fontWeight: FontWeight.normal,),),),),                      
                      Padding(padding: const EdgeInsets.only(bottom: 2), child: Container(child: Text('Price ' + myPrice.toString()+' BHT',style: TextStyle(fontWeight: FontWeight.normal,),),),),     
            ],), ),
                Column
                (crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
                  //=========================================================================
                  // COUNTER BUTTON
                  //=========================================================================
                  // new Counter( initialValue:_counterArr[myMenuId]??1, minValue: 1, maxValue: 10, step: 1 , onChanged: (value) {
                  //   setState(() {
                  //     _counterArr[myMenuId] = value;
                  //   });
                  // }, decimalPlaces: 0),
                  //=========================================================================
                  // TEXT
                  //=========================================================================                  
                  Text('' ),
                  //=========================================================================
                  // BUTTON
                  //=========================================================================     
                  RaisedButton(onPressed: (){fnSaveOrder(myMenuId,myName,myDescription,myPrice,imageUrl,1??1 );},child: Text('Order Now'),color: Colors.orange,),                               
                  //RaisedButton(onPressed: (){fnSaveOrder(myMenuId,myName,myDescription,myPrice,imageUrl,_counterArr[myMenuId] );},child: Text('Order Now'),color: Colors.orange,),
                ],)
          ],
        ),
      ),
    );
  } //widget

  //=======================================================================================
  // FUNCTION: SAVE ORDER
  //=======================================================================================
  fnSaveOrder(String myId,String myName, String myDescription, double myPrice, String imageUrl, int myQty){
        //=================================================================================
    // PREPARE DATA
    //=====================================================================================       
    ROrderModel myModel = ROrderModel(id: 'ORD001',name: myName,description: myDescription, qty: myQty, customer: "Mr.Sornchai", menuId: myId, table: 'T001', imageUrl: imageUrl);
    //=====================================================================================
    // SHOW LOG
    //=====================================================================================   
    logger.i(myModel.toFileStone());
    //=====================================================================================
    // SAVE DB TO FIRESTORE
    //===================================================================================== 
    String _timestampstr = DateTime.now().millisecondsSinceEpoch.toString();    
    Firestore.instance.collection("TT_ORDER").document(_timestampstr).setData(myModel.toFileStone()) ; 
    setState(() {
          logger.i('Insert Order Complete') ;
    });      // SAVE DB
  }
  //=======================================================================================
  // BOTTOM NAV BAR
  //=======================================================================================
  Widget myBottomNavBar(){
    return BottomNavigationBar(
         backgroundColor: Colors.black,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap:(int i){
          setState((){
            index=i;
          });}, currentIndex: index,
          items: <BottomNavigationBarItem> [homeNav(),menuNav(),orderNav(),moreNav()],
    );
  }

  //======================================================
  // BOTTOM NAV BAR (ITEM)
  //======================================================
  BottomNavigationBarItem homeNav() => BottomNavigationBarItem(icon: Icon(Icons.home), title:  Text('Home'), );
  BottomNavigationBarItem menuNav() => BottomNavigationBarItem(
    icon: StreamBuilder(
      initialData: _orderItemCount,
      stream:  Firestore.instance.collection("TT_ORDER").snapshots(),
      builder: (BuildContext context, AsyncSnapshot _shapshot) => BadgeIcon(
        icon:Icon(Icons.add_shopping_cart, size: 25,),
       badgeCount:  _shapshot.data.documents.length??0        
    ), 
    ),
    title:  Text('New'));
  BottomNavigationBarItem orderNav() => BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), title:  Text('Order'));
  BottomNavigationBarItem moreNav() => BottomNavigationBarItem(icon: Icon(Icons.menu), title:  Text('More'));

}// CLASS




