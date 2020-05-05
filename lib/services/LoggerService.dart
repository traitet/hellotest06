//=================================================================================
// 1) IMPORT
//=================================================================================
import 'package:logger/logger.dart';

//=================================================================================
// 2) PRINT IN DEBUG CONSSOLE
//=================================================================================
var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true),
);
