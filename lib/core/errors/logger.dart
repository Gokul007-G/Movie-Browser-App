import 'package:flutter/material.dart';

class Logger {
  static void i(dynamic data) {
    debugPrint('INFO : $data');
  }

  static void e(dynamic data) {
    debugPrint('ERROR : $data');
  }

  static void w(dynamic data) {
    debugPrint('WARNING : $data');
  }
}
