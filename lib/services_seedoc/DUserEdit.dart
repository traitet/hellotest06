import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../services/ShowNotification.dart';
import '../services/LoggerService.dart';
import '../models_seedoc/DUserModel.dart';

//==================================================================================
// FUNCTION: SIGNUP USER
//==================================================================================  
Future<void> dUserEdit(
  //================================================================================
  // 1) PARAMETER: (1) PARA1: DATA, PARA2: DOCUMENT
  //================================================================================    
  BuildContext context,  DUserModel data, String documentName){
      //  logger.i(data.toFileStone());
      var a = data.toFileStone();
      logger.i(a.toString());
    //==============================================================================
    // 2) RETURN 
    //==============================================================================       
    return
    //==============================================================================
    // 3) CALL SET DATA (INSERT)
    //==============================================================================
    Firestore.instance.collection("TM_USER").document(documentName).setData(data.toFileStone()).then((returnData) {
      //============================================================================
      // 4) SHOW MESSAGE AFTER SUCCESS
      //============================================================================         
      showMessageBox(context, "Success", "Register User($documentName) to completely", actions: [dismissButton(context)]);
      logger.i("setData Success");
      //============================================================================
      //5)SHOW MESSAGE IF ERROR
      //============================================================================         
      }).catchError((e){
        logger.e("setDAta Error");
        logger.e(e);
      });
    }
