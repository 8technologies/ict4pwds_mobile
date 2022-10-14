import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/screens/auth/login.dart';
import 'package:ict4pwds_mobile/screens/auth/register.dart';
import 'package:ict4pwds_mobile/screens/dashboard/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  String intialRoute = "/login";
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("access") != null && prefs.getString("refresh") != null) {
    intialRoute = "/home";
  }
  
  runApp(MyApp(isLoggedin: intialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isLoggedin}) : super(key: key);

  // This widget is the root of your application.
  final String? isLoggedin;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ICT FOR PWDs',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: isLoggedin,
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => const Login(),
          "/register": (BuildContext context) => const Register(),
          "/home": (BuildContext context) => const Home(),
        });
  }
}
