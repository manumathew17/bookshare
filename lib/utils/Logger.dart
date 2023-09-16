import 'package:flutter/foundation.dart';

class Logger {
  static log(dynamic data) {
    if (kDebugMode) {
      print(data);
    }
  }
}
