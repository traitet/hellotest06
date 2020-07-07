//======================================================================================
// IMPORT
//======================================================================================
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hellotest06/models_seelastminute/LDealTypeModel.dart';
import 'package:image_picker/image_picker.dart';
import '../models_seelastminute/LDealModel.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
import 'package:path/path.dart' as Path;


//========================================================================================
// MAIN CLASS
//========================================================================================
class LCreateDealPage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;

  LCreateDealPage({Key key, @required this.email}): super(key: key);  
  @override
  _LCreateDealPageState createState() => _LCreateDealPageState();
}

class _LCreateDealPageState extends State<LCreateDealPage> {
//======================================================================
// DECLARE TEXT EDIT CONTROLLER
//====================================================================== 
      //final _createdByController = TextEditingController()..text;
      final _nameController = TextEditingController()..text = 'Create Last Minute Deal';
      final _descriptionController = TextEditingController()..text = 'Document on 18 May 2020'; 
      final _street1Controller = TextEditingController()..text = '';
      String _street2 = 'One';    
      String _street3 = 'Food' ;
      String _street4 = 'Promotion' ;      
      var _listStreet3 = ["Food","Transport","Personal","Shopping","Medical","Rent","Movie","Salary"];
      List<String> _listStreet4 ;
      LDealTypeModel _dealTypemodel;

      final String _timestampstr = DateTime.now().millisecondsSinceEpoch.toString();    
      //====================================================================================
      // 1) DECLARE VARIABLE FOR UPLOAD IMAGE
      //====================================================================================
      File _image;
      String _uploadedFileURL;
//========================================================================================
// INITSTATTE
//========================================================================================      
@override
void initState() {
  super.initState();
      Firestore.instance.collection('LTM_DEALTYPE').document('1590768308368').get().then((value) {
      setState(() {
        _dealTypemodel = LDealTypeModel.fromFilestore(value);
        logger.i(_dealTypemodel.types);
        _listStreet4 = _dealTypemodel.types;
      });
    });
  }

//========================================================================================
// WIDGET
//========================================================================================
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Doc: ' + _timestampstr),),
      body: ListView(children: <Widget>[


//======================================================================
// TEXT INPUT
//======================================================================         
            TextFormField(decoration: InputDecoration(labelText: '*Name', prefixIcon: Icon(Icons.near_me)),controller: _nameController,),
            TextFormField(decoration: InputDecoration(labelText: '*Description', prefixIcon: Icon(Icons.vpn_key)),controller: _descriptionController),       
            TextFormField(decoration: InputDecoration(labelText: '*Street1', prefixIcon: Icon(Icons.vpn_key)),controller: _street1Controller),    
            buildDropdownStreet3() ,
            BuildDropDownStreet2(),
            _listStreet4 != null?  buildDropdownStreet4():null,
      
//========================================================s==============
// SAVE INPUT
//==============================================================s========             
            RaisedButton(onPressed: () {
//======================================================================
// SAVE INPUT
//======================================================================
              // await fnUploadFile();  
             // logger.i('upload image completed: ' + _uploadedFileURL??''  );          
//======================================================================
// PREPARE LIST
//======================================================================               
              List<WorkFlow> workFlows = new List<WorkFlow>(3) ;
              workFlows[0] = WorkFlow(action: 'ISSUE',userName: 'traitet',comment: 'document issued');               
              workFlows[1] = WorkFlow(action: 'APPROVE',userName: 'satit',comment: 'document issued');
              workFlows[2] = WorkFlow(action: 'REJECT',userName: 'tananum',comment: 'document issued');              
 //======================================================================
// SAVE TO DB
//======================================================================        
              LDealModel myModel = LDealModel(docType: "DEAL",name: _nameController.text,description: _descriptionController.text, createdBy: widget.email,imageUrl: _uploadedFileURL,
                  streets: ['a','b','c'], 
                  workflows:workFlows);
              //logger.i(myModel.toFileStone());
              Map<String,dynamic> a = myModel.toFileStore();
              logger.i(myModel);              
              logger.i(a);
              Firestore.instance.collection('LTT_DEAL').document(_timestampstr).setData(myModel.toFileStore());
//======================================================================
// SAVE COMPLETE
//======================================================================               
              setState(() {
                logger.i('Insert Order Completed');
                showMessageBox(context, "success", "Register Document($_timestampstr) to Firestore Database completely", actions: [dismissButton(context)]);
              });
//======================================================================
// UPDATE INSIDE
//======================================================================                 
              myModel = LDealModel(docType: "DEAL",name: _nameController.text,description: _descriptionController.text, createdBy: widget.email,imageUrl: _uploadedFileURL,
                  streets: ['a','b','c1234'], workflows:workFlows);
              Firestore.instance.collection('LTT_DEAL').document(_timestampstr).setData(myModel.toFileStore());          
//======================================================================
// UPDATE CHILD
//====================================================================== 
              myModel.createdBy = 'traitet@hotmail222.com';
              var newCityRef = Firestore.instance.collection("LTT_DEAL").document(_timestampstr);
              newCityRef.updateData({ 'createdBy' : myModel.createdBy });
              newCityRef.updateData({ 'streets' : ['a13242','b1234','c1234'] });      
//======================================================================
// GET DATA / UPDATE DATA
//====================================================================== 
            Firestore.instance.collection("LTT_DEAL").document(_timestampstr).get().then((value){
              LDealModel myModel2 = LDealModel.fromFilestore(value);
              myModel2.createdBy = 'abc@hotmail.com';
              myModel2.streets = [_street1Controller.text,_street2,_street3];
              var newCityRef2 = Firestore.instance.collection("LTT_DEAL").document(_timestampstr);
              newCityRef2.updateData(myModel2.toFileStore());
            }).catchError((e)
            {}
            );
//======================================================================
// NEW MASTER (SAMPLE)
//======================================================================   
              // Firestore.instance.collection('LTM_DEALTYPE').document(_timestampstr).setData({'type':['Promotion','New Release','One day deal']});            

//======================================================================
// UPDATE CHILD
//====================================================================== 
              // List<WorkFlow> workFlows2 = new List<WorkFlow>(2) ;
              // workFlows2[0] = WorkFlow(action: 'ISSUE',userName: 'traitet',comment: 'document issued est');               
              // workFlows2[1] = WorkFlow(action: 'APPROVE',userName: 'satit',comment: 'document issued');
              //     myModel = LDealModel(docType: "DEAL",name: _nameController.text,description: _descriptionController.text, createdBy: widget.email,imageUrl: _uploadedFileURL,
              //     streets: ['a','b','c'], 
              //     workflows:workFlows2);
              // logger.i(myModel.toFileStore());
              //   Firestore.instance.collection('LTT_DEAL').document(_timestampstr).setData(myModel.toFileStore());                     
//======================================================================
// BUTTON TEXT
//====================================================================== 
             }, child: Text('Save New Document'),),       
             
//======================================================================
// SELECT IMAGE BUTTON
//====================================================================== 
          RaisedButton(child: Text("Select Image"), onPressed: chooseFile),
//======================================================================
// SHOW IMAGE
//====================================================================== 
         _image != null ? Image.asset(_image.path,height: 200,): Center(child: Text('Click above botton to select image')),

      ],),
      
    );
  }

//**************************************************************************************************************************/
// WIDGET
//**************************************************************************************************************************/

//======================================================
// WIDGET:IMAGE BODY WIDGET
//======================================================
Widget widgetBodyImage() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset('assets/images/bg01.jpg',
          width: 300, height: 200, fit: BoxFit.cover),
    );


//====================================================================================
// FUNCTION: CHOOSE FILE
//====================================================================================
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {setState(() {_image = image;});
  });
  }

//====================================================================================
// FUNCTION#2: UPLOAD
//====================================================================================
  Future fnUploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    logger.i('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }
//====================================================================================
// WIDGET BUILD DROPDOWN
//====================================================================================
  buildDropdownStreet3() => 
    FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              isEmpty: _street3 == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _street3,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _street3 = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _listStreet3.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),),);},);


//====================================================================================
// WIDGET BUILD DROPDOWN
//====================================================================================
  buildDropdownStreet4() => 
    FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'Please select expense',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              isEmpty: _street4 == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _street4,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _street4 = newValue;
                      state.didChange(newValue);
                    });
                  },
                  items: _listStreet4.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),),);},);

} // CLASS


//====================================================================================
// WIDGET: DROPDOWN "STREET2"
//====================================================================================

class BuildDropDownStreet2 extends StatefulWidget {
  BuildDropDownStreet2({Key key}) : super(key: key);

  @override
  _BuildDropDownStreet2State createState() => _BuildDropDownStreet2State();
}

class _BuildDropDownStreet2State extends State<BuildDropDownStreet2> {
  String dropdownValue = 'Suksawat';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 30,
      // elevation: 16,
      // style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Suksawat', 'Ratburana', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

