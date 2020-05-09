import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellotest06/models_seerest/RMenuModel.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';


//=====================================================================================
// MAIN CLASS
//=====================================================================================
class RMenuNewPage extends StatefulWidget {
  final String docId;
  //======================================================================================
  // PARAMETER
  //======================================================================================
  RMenuNewPage({Key key,this.docId}): super(key: key);
  //====================================================================================
  // OVERRIDE
  //==================================================================================== 
  @override
  _RMenuNewPageState createState() => _RMenuNewPageState();
}

//=====================================================================================
// STATE CLASS
//=====================================================================================
class _RMenuNewPageState extends State<RMenuNewPage> {
  //===================================================================================
  // 1) DECLARE VARIABLE
  //===================================================================================
  final _menuIdController = TextEditingController();
  final _nameController = TextEditingController(); 
  final _descriptionController = TextEditingController();  
  final _priceController = TextEditingController();  
   
  RMenuModel myMenuModel;

  //======================================================================================
  // 3) INIT: GET DATA FROM DB
  //======================================================================================
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('TM_REST_MENU').document(widget.docId).get().then((myDocument) {
      //===================================================================================
      // 3.1) AFTER GET DATA
      //===================================================================================
      setState(() {

        myMenuModel = RMenuModel.fromFilestore(myDocument);
        _menuIdController.text = myMenuModel.menuId;        
        _nameController.text = myMenuModel.name;        
        _descriptionController.text = myMenuModel.description;
        _priceController.text = myMenuModel.price.toString();

      if (myDocument.data.length == 0 ) {

      } 
      });
    });
  }
  //=========================================================================================
  // BUILD WIDGET
  //=========================================================================================
  @override
  Widget build(BuildContext context) {

    //=======================================================================================
    // RETURN SCAFFOLD
    //=======================================================================================      
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant Food Menu: ' ),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(child: ListView(    
          children: <Widget>[
            //==============================================================================
            // 1) TEXTBOX 
            //==============================================================================  
                           
            TextFormField(decoration: InputDecoration(labelText: 'Menu ID', prefixIcon: Icon(Icons.perm_identity)),controller: _menuIdController),
            TextFormField(decoration: InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.people)),controller: _nameController),          
            TextFormField(decoration: InputDecoration(labelText: 'Description', prefixIcon: Icon(Icons.description)),controller: _descriptionController,),  
            TextFormField(decoration: InputDecoration(hintText: 'Price', labelText: 'Price', prefixIcon: Icon(Icons.confirmation_number)),controller: _priceController,keyboardType: TextInputType.number,),                             
                          
            //==============================================================================
            // 2) BUTTON
            //==============================================================================                
            Container(
              // margin: EdgeInset.all(50.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RaisedButton(onPressed: ()
                {
                  //========================================================================
                  // 3) PRINT LOG
                  //======================================================================== 
                  logger.i("Name" + _nameController.text);
                  logger.i("Description " + _descriptionController.text);
                  //========================================================================
                  // 4) VALIDATE
                  //========================================================================             
                  if (_nameController.text == "" || _descriptionController.text ==""){
                    showMessageBox(context, "Error", "Please enter username or Emp ID", actions: [dismissButton(context)]);
                    logger.e("Name or Description cannot be null");              
                  } // IF
                  //========================================================================
                  // 5) SIGNUP USER
                  //========================================================================             
                  else {
                    //======================================================================
                    // PREPARE VALUE
                    //====================================================================== 

                    myMenuModel = RMenuModel(
                      menuId: _menuIdController.text,
                      name: _nameController.text,                      
                      description: _descriptionController.text,
                      price: double.parse(_priceController.text),

                      );

                      logger.i(myMenuModel.toFileStone());
                 
     

                    //======================================================================
                    // UPDATE DATA TO DB
                    //======================================================================    
                    Firestore.instance.collection("TM_REST_MENU").document('MENU001').setData(myMenuModel.toFileStone()).then((returnData) {
                    //============================================================================
                    // 4) SHOW MESSAGE AFTER SUCCESS
                    //============================================================================         
                    showMessageBox(context, "Success", "Register Menu($myMenuModel) to completely", actions: [dismissButton(context)]);
                    logger.i("setData Success");
                    // GET DOCUMENT ID  
                    //============================================================================
                    //5)SHOW MESSAGE IF ERROR
                    //============================================================================         
                    }).catchError((e){
                      logger.e("setDAta Error");
                      logger.e(e);
                    });
                  }              
                  
                  //========================================================================
                  // 6) BUTTON NAME
                  //========================================================================                         
                },child: Text('SAVE'),),
              ),
            ),      
          ],
        )
        ),
       ),
    );
  }
}