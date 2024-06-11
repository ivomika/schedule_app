import 'package:flutter/foundation.dart';

class Debugger{
  static void log(String text){
    if(kDebugMode){
      print(text);
    }
  }
}