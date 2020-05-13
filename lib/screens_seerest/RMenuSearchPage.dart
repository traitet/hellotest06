//========================================================
// IMPORT
// REF: NAV BAR: https://www.androidthai.in.th/android-flutter/389-bottom-navigation-bar-on-flutter.html
//========================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/screens_seerest/ROrderPage..dart';
import 'package:hellotest06/widgets/BadgeIcon.dart';
import '../screens_seerest/RMenuViewPage.dart';
import '../models_seerest/ROrderModel.dart';
import '../services/LoggerService.dart';
// import 'package:path/path.dart' as Path;
// import 'dart:io';

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
  int _countOrderItem = 0;
  int _orderItemQty = 0;
  int _orderItemCount = 0;  
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
          _orderItemQty = myDocuments.documents.length;
      });
    });
  }

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
        title: Text('Menu Search: ' + _orderItemQty.toString()),       
        actions: <Widget>[IconButton(
            icon: StreamBuilder(
            initialData: _orderItemCount,
            stream:  Firestore.instance.collection("TT_ORDER").snapshots(),
            builder: (BuildContext context, AsyncSnapshot _shapshot) => BadgeIcon(icon:Icon(Icons.add_shopping_cart, size: 25,),
            badgeCount:  _shapshot.data.documents.length        
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
      body: StreamBuilder(
        //==================================================================================
        // GET DATA FROM DB
        //==================================================================================         
        stream: Firestore.instance.collection("TM_REST_MENU").snapshots(),
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
                // GET DATA FROM DB
                //==========================================================================     
                String _docId = snapshot.data.documents[index].documentID; 
                String _name =  snapshot.data.documents[index].data["name"];  
                String _description =  snapshot.data.documents[index].data["description"];  
                double _price =  snapshot.data.documents[index].data["price"]??100;     
                String _imageUrl =  snapshot.data.documents[index].data["imageUrl"]??'';                                                                                 
              return Padding(padding: const EdgeInsets.all(8.0),
                   
                  child: Card(  child: Container( child: InkWell(
                    onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => RMenuViewPage(menuId: snapshot.data.documents[index].documentID,)));},                   
                    child: Column(children: <Widget>[
                      widgetBodyText(_docId,_name,_description,_price,_imageUrl),        
                    ],),),),));
              }, //Return#1
            );
           } //Else
         } // Builder
      )
    );
  }





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
                  // BUTTON
                  //=========================================================================
                  Text('Qty: 1'),
                  RaisedButton(onPressed: (){fnSaveOrder(myMenuId,myName,myDescription,myPrice,imageUrl);},child: Text('Order Now'),color: Colors.orange,),
                ],)
          ],
        ),
      ),
    );
  } //widget

  //=======================================================================================
  // FUNCTION: SAVE ORDER
  //=======================================================================================
  fnSaveOrder(String myId,String myName, String myDescription, double myPrice, String imageUrl, ){
        //=================================================================================
    // PREPARE DATA
    //=====================================================================================       
    ROrderModel myModel = ROrderModel(id: 'ORD001',name: myName,description: myDescription, qty: 1, customer: "Mr.Sornchai", menuId: myId, table: 'T001', imageUrl: imageUrl);
    logger.i(myModel);
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
          _countOrderItem++;
          logger.i('Insert Order Complete: ' + _countOrderItem.toString() + ' item(s)') ;
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
       badgeCount:  _shapshot.data.documents.length        
    ), 
    ),
    title:  Text('New'));
  BottomNavigationBarItem orderNav() => BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), title:  Text('Order'));
  BottomNavigationBarItem moreNav() => BottomNavigationBarItem(icon: Icon(Icons.menu), title:  Text('More'));

}// CLASS




