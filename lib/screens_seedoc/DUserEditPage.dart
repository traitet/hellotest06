import 'package:flutter/material.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
import '../services/SignupUser.dart';


//=====================================================================================
// MAIN CLASS
//=====================================================================================
class DUserEditPage extends StatefulWidget {
  //======================================================================================
  // PARAMETER
  //======================================================================================
  final String email;
  DUserEditPage({Key key, @required this.email,}): super(key: key);
  //====================================================================================
  // OVERRIDE
  //==================================================================================== 
  @override
  _DUserEditPageState createState() => _DUserEditPageState();
}

//=====================================================================================
// STATE CLASS
//=====================================================================================
class _DUserEditPageState extends State<DUserEditPage> {
  //===================================================================================
  // 1) DECLARE VARIABLE
  //===================================================================================
  final _emailController = TextEditingController();
  final _empIdController = TextEditingController(); 
  final _firstnameController = TextEditingController();  
  final _lastnameController = TextEditingController();  
  final _lineidController = TextEditingController();    
  final _mobilenoController = TextEditingController();  
  final _companyTaxIdController = TextEditingController();  
  final _companyNameController = TextEditingController();   

  @override

  Widget build(BuildContext context) {
    _emailController.text = widget.email;
    String _firstName =  widget.email.split('@')[0].split('_')[0].split('.')[0];
    String _lastName =  widget.email.split('@')[0].split('_')[1];    
    String _companyName = widget.email.split('@')[1].split('.')[0];
    _firstnameController.text = _firstName[0].toUpperCase() + _firstName.substring(1);
    _lastnameController.text = _lastName[0].toUpperCase() + _lastName.substring(1);
    _companyNameController.text = _companyName[0].toUpperCase() + _companyName.substring(1);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile: ' + widget.email),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(child: ListView(    
          children: <Widget>[
            //==========================================================================
            // 1) TEXTBOX 
            //==========================================================================              
            TextFormField(decoration: InputDecoration(labelText: '*E-mail', prefixIcon: Icon(Icons.email)),controller: _emailController),
            TextFormField(decoration: InputDecoration(labelText: '*Emp ID', prefixIcon: Icon(Icons.people)),controller: _empIdController),          
            TextFormField(decoration: InputDecoration(labelText: '*First Name', prefixIcon: Icon(Icons.first_page)),controller: _firstnameController,),  
            TextFormField(decoration: InputDecoration(hintText: 'If have middle name fiill in this', labelText: '*Last Name', prefixIcon: Icon(Icons.last_page)),controller: _lastnameController,),                             
            TextFormField(decoration: InputDecoration(hintText: 'For send notification and Line chat',labelText: 'Line ID', prefixIcon: Icon(Icons.network_cell)),controller: _lineidController),
            TextFormField(decoration: InputDecoration(hintText: 'For sending SMS notification',labelText: 'Mobile No', prefixIcon: Icon(Icons.phone)),controller: _mobilenoController,keyboardType: TextInputType.number,),                                    
            TextFormField(decoration: InputDecoration(hintText: 'Use Company TAX ID 13 digits',labelText: 'Company Tax ID', prefixIcon: Icon(Icons.code)),controller: _companyTaxIdController,
              validator: (String value) {return value.contains('@') ? 'Do not use the @ char.' : null;},),  
            TextFormField(decoration: InputDecoration(labelText: 'Company Name', prefixIcon: Icon(Icons.home)),controller: _companyNameController,),                  
            //==========================================================================
            // 2) BUTTON
            //==========================================================================                
            Container(
              // margin: EdgeInset.all(50.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RaisedButton(onPressed: ()
                {
                  //========================================================================
                  // 3) PRINT LOG
                  //======================================================================== 
                  logger.i("E-mail" + _emailController.text);
                  logger.i("Emp ID " + _empIdController.text);
                  //========================================================================
                  // 4) VALIDATE
                  //========================================================================             
                  if (_emailController.text == "" || _empIdController.text ==""){
                    showMessageBox(context, "Error", "Please enter username or Emp ID", actions: [dismissButton(context)]);
                    logger.e("Username or Emp ID cannot be null");              
                  } // IF
                  //========================================================================
                  // 5) SIGNUP USER
                  //========================================================================             
                  else {
                    signupUser(context, {
                      "username": _emailController.text, 
                      "empid": _empIdController.text,
                      "firstname": _firstnameController.text,
                      "lastname": _firstnameController.text,
                      "lineid": _lineidController.text ,
                      "mobileno": _mobilenoController.text ,
                      "company_taxid": _companyTaxIdController.text,
                      "company_name": _companyNameController.text,
                    }, _emailController.text);                    
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