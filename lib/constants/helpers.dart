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

  static List getLastNameCommaFirstName(String fullName) {
    List<String> names = fullName.split(' ').toList();
    String firstName = names.first;
    names.removeAt(0);

    return [names.join(" "), firstName];
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) return "Full name is required";

    var name = Helpers.getLastNameCommaFirstName(value);
    if (name[0].isEmpty) return "Enter your full name";

    return null;
  }
}
