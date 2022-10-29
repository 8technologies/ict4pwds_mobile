import 'package:flutter/material.dart';

class Helpers {
  static Size displaySize(BuildContext context) {
    //debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  static String truncateString(String data, int length) {
    return (data.length >= length) ? '${data.substring(0, length)}...' : data;
  }
}