import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/screens/auth/login.dart';
import 'package:ict4pwds_mobile/screens/auth/register.dart';
import 'package:ict4pwds_mobile/screens/dashboard/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ICT FOR PWDs',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: "/login",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => const Login(),
          "/register": (BuildContext context) => const Register(),
          "/home": (BuildContext context) => const Home(),
        });
  }
}