//=================================================================================
// 1) IMPORT
//=================================================================================
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';


//================================================================================
// 2) FUNCTION: ADD ITEM (FUTURE => ASYN FUNCTION)
//================================================================================
Future<void> setDBFoodMenu(
    BuildContext context, String catalogName,String documentName,  Map<String, dynamic> data) {
  //==============================================================================
  // RETURN FUNCTION
  //==============================================================================   
  return 

  Firestore.instance
      //==========================================================================
      // SAVE DATA TO DB: CATALOG, DOCUMENTNAME, DATA
      //==========================================================================  
      .collection(catalogName)    //COLLECTION NAME: CATALOG
      .document(documentName)   //DOCUMENTNAME:  [ PRODUCT NAME ]
      .setData(data)            //SAVE DATA "DYNAMIC"
      .then((returnData) {      
        //========================================================================
        // SHOW MESSAGE: TO UI
        //========================================================================          
        showMessageBox(context, "Success", "Registered Document($documentName) to Firestore Database completely.",
        //========================================================================
        // ONLY DISMISS BUTTON
        //========================================================================
        actions: [dismissButton(context)]);
    //============================================================================
    // KEEP LOG SET DATA SUCREE ( SENT TO DEBUG CONSULT )
    //============================================================================          
    logger.i("setData success");
    //============================================================================
    // SHOW ERROR
    //============================================================================      
  }).catchError((e) {
        logger.e("setData ERROR");
    logger.e(e);
  });
}
