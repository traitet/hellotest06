  //========================================================
  // IMPORT
  //========================================================  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/models_seerest/ROrderModel.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';

  //======================================================================================
  // MAIN CLASS
  //======================================================================================  
class ROrderItemEditPage extends StatefulWidget {
  //======================================================================================
  // VARIABLE AND CONSTUCTURE
  //======================================================================================    
  final String menuId;
  final String orderItemId;
  ROrderItemEditPage({Key key, @required this.menuId, @required this.orderItemId}): super(key: key);  
  //======================================================================================
  // OVERRICE BUILD
  //======================================================================================    
  @override
  _ROrderItemEditPageState createState() => _ROrderItemEditPageState();
}
//==========================================================
// STATE CLASS
//========================================================================================  
class _ROrderItemEditPageState extends State<ROrderItemEditPage> {
  String _uploadedFileURL = '';  
  var snapshotMenuCatList;
  ROrderModel  _model; 
 
  //======================================================================================
  // DECALRE VARIABLE
  //======================================================================================  
  final _idController = TextEditingController()..text = '';
  final _nameController = TextEditingController()..text = 'Fried rice';
  final _descriptionController = TextEditingController()..text = 'ข้าวผัด';
  final _imageUrlController = TextEditingController()..text = 'www.imagefoodmenu.com';   
  final _priceController = TextEditingController()..text = '100';
  final _qtyController = TextEditingController()..text = '4';  
  final _menuIdController = TextEditingController()..text = 'MENU ID';  

//=========================================================================================
// 4) GET DATA FROM DB ?? YES
//=========================================================================================
  @override
  void initState() {
    super.initState();
    logger.i(widget.menuId);
    Firestore.instance.collection("TT_ORDER").document(widget.orderItemId).get().then((value) {
      setState(() {
        //=================================================================================
        // 4) GET DATA FROM DB ?? YES
        //=================================================================================       
        _model = ROrderModel.fromFilestore(value);  
        _idController.text = _model.id;
        _menuIdController.text = _model.menuId;
        _nameController.text = _model.name;
        _descriptionController.text = _model.description;
        _imageUrlController.text = _model.imageUrl;
        _uploadedFileURL = _model.imageUrl;
        _qtyController.text = _model.qty.toString();        
        logger.i(value.data.toString());        
      });
    });
  }

  //=========================================================================================
  // OVERRIDE (IMPLEMENT UI)
  //=========================================================================================   
  @override
  Widget build(BuildContext context) {         
    return Scaffold(
      appBar: AppBar(title: Text('Edit Order: ' + widget.menuId),),    
      body: ListView(
        children: <Widget>[
          _idController.text == '' ? Text("Loading . . . "):
          //================================================================================
          // BUILD WIDGET IMAGE AND TEXT (1) UPLOAD 2) GOOGLE 3) WRONG URL
          //================================================================================
            _uploadedFileURL != '' ? Container(padding: const EdgeInsets.all(8.0),height: 200,child: Image.network(_imageUrlController.text)):
            widgetBodyImage(),     
    
          //================================================================================= 
          // UI: TEXT
          //=================================================================================  
          TextFormField(decoration: InputDecoration(labelText: 'Menu ID', prefixIcon: Icon(Icons.insert_chart)),controller: _menuIdController,),
          TextFormField(decoration: InputDecoration(labelText: 'Menu Name', prefixIcon: Icon(Icons.insert_chart)),controller: _nameController,),
          TextFormField(decoration: InputDecoration(labelText: 'Menu Description', prefixIcon: Icon(Icons.insert_chart)),controller: _descriptionController,),
          TextFormField(decoration: InputDecoration(labelText: 'Price', prefixIcon: Icon(Icons.insert_chart)),controller:_priceController,), 
          TextFormField(decoration: InputDecoration(labelText: 'Qty', prefixIcon: Icon(Icons.insert_chart)),controller:_qtyController,keyboardType: TextInputType.number,),           
          //=================================================================================
          // UI: SAVE BUTTON
          //=================================================================================                      
          RaisedButton(onPressed: (){fnSave();}, child: Text('SAVE'),),               
        ],
      ),
    );
  }
 
  //============================================================================================
  // SAVE (COLLECTION=TABLE, DOCUMENT=PK)
  //============================================================================================   
  fnSave() async {
    //==========================================================================================
    // PREPARE DATA
    //==========================================================================================       
    ROrderModel myModel = ROrderModel(
      id: _idController.text,
      name: _nameController.text, 
      description: _descriptionController.text, 
      imageUrl: _uploadedFileURL,    
    );
    logger.i(myModel);
    //===========================================================================================
    // SHOW LOG
    //===========================================================================================   
    logger.i(myModel.toFileStone());
    //===========================================================================================
    // SAVE DB TO FIRESTORE
    //===========================================================================================     
    Firestore.instance.collection("TT_ORDER").document(_idController.text).setData(myModel.toFileStone())        // SAVE DB
    .then((returnDocuments){        // IF COMPLETE
      logger.i('Insert Complete');  // PRINT LOG
      showMessageBox(context, "Success", _idController.text + " saved completely", actions: [dismissButton(context)]);   //POP UP COMPLETE
    }
    ).catchError((e){               // IF ERROR
        logger.e("Insert Error");   // PRINT LOG
    }); 
  }

  //============================================================================================
  // WIDGET:IMAGE BODY WIDGET
  //============================================================================================
  Widget widgetBodyImage() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/bg01.jpg',
            width: 300, height: 200, fit: BoxFit.cover),
  );





}