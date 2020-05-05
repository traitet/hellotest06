import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../services/LoggerService.dart';
import '../services/ShowNotification.dart';
//==================================================================================
// FUNCTION: SIGNUP USER
//==================================================================================

Future<void> dDocNew(BuildContext context, Map<String, dynamic> data,
    String documentName) async {
  //================================================================================
  // 1) DECLARE VARIABLE
  //================================================================================
  final _dbref = Firestore.instance;
  //================================================================================
  // 2) NEW DOCUMENT
  //================================================================================
//   DocumentReference ref = await _dbref.collection("TT_DOCUMENT").add(data);
//   String _docId = ref.documentID;
//   showMessageBox(context, "success",
//       "Register Document($_docId) to Firestore Database completely",
//       actions: [dismissButton(context)]);
//   logger.i(ref.documentID);
//   return ref.documentID.toString();
// }

//==============================================================================
// SET DATA
//==============================================================================
_dbref.collection("TT_DOCUMENT").document(documentName).setData(data).then((returnData) {
  showMessageBox(context, "success",
      "Register Document($documentName) to Firestore Database completely",
      actions: [dismissButton(context)]);
  logger.i("setData Success");
}).catchError((e) {
  logger.e("setDAta Error");
  logger.e(e);
});
}
