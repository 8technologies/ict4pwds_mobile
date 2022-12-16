import 'package:flutter/material.dart';

class NavigationService {
  /// Creating the first instance
  static final NavigationService _instance = NavigationService._internal();
  NavigationService._internal();

  factory NavigationService() => _instance;
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  /// For navigating back to the previous screen
  dynamic goBack([dynamic popValue]) {
    return navigationKey.currentState?.pop(popValue);
  }

  /// This allows you to naviagte to the next screen by passing the screen widget
  Future<dynamic> navigateToScreen(Widget page, {arguments}) async =>
      navigationKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );

  /// This allows you to naviagte to the next screen and
  /// also replace the current screen by passing the screen widget
  Future<dynamic> replaceScreen(Widget page, {arguments}) async =>
      navigationKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );

  Future<dynamic> popToFirst(Widget page, {arguments}) async =>
      navigationKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => page,
          ),
          (route) => false);
}
