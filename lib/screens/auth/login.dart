import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/screens/auth/register.dart';
import 'package:ict4pwds_mobile/screens/dashboard/home.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

  void login() {}
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: const <Widget>[
              SizedBox(
                  child: Image(
                image: AssetImage('assets/img/logo.png'),
                height: 70,
                width: 70,
              )),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          const SizedBox(
              width: double.infinity,
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              )),
          const SizedBox(
            height: 15.0,
          ),
          const SizedBox(
            width: double.infinity,
            child: Input(placeholder: "Email Address"),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(
            width: double.infinity,
            child: Input(placeholder: "Password", isPassword: true),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  loginFunction();
                },
                style: TextButton.styleFrom(
                    backgroundColor: ArgonColors.primary,
                    padding: const EdgeInsets.only(top: 15, bottom: 15)),
                child: const Text(
                  "Login",
                  style: TextStyle(color: ArgonColors.white),
                )),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Future(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    });
                  },
                  child: const Text(
                    'Create Account',
                    textAlign: TextAlign.left,
                  ),
                ),
                const Text(
                  'Reset Password',
                  textAlign: TextAlign.right,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  loginFunction() {
    // validate input
    Future(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }
}
