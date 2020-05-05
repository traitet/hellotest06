import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../services/LoggerService.dart';
// import '../services/ShowNotification.dart';
//==================================================================================
// FUNCTION: SIGNUP USER
//==================================================================================  
Future<void> dDocUpdate(
  //================================================================================
  // 1) PARAMETER: (1) PARA1: DATA, PARA2: DOCUMENT
  //================================================================================    
  BuildContext context, Map<String, dynamic> data, String documentName) async  {
    //==============================================================================
    // 2) RETURN 
    //==============================================================================       
    return
    //==============================================================================
    // 3) CALL SET DATA (INSERT)
    //==============================================================================       
    Firestore.instance.collection("TT_DOCUMENT").document(documentName).setData(data).then((returnData) {
      //============================================================================
      // 4) SHOW MESSAGE AFTER SUCCESS
      //============================================================================         
      // showMessageBox(context, "success", "Submit Document($documentName) to Firestore Database completely", actions: [dismissButton(context)]);
      logger.i("setData Success");
      //============================================================================
      //5)SHOW MESSAGE IF ERROR
      //============================================================================         
      }).catchError((e){
        logger.e("setDAta Error");
        logger.e(e);
      });
    }
