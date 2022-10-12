import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/screens/auth/login.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                "Create Account",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              )),
          const SizedBox(
            height: 15.0,
          ),
          const SizedBox(
            width: double.infinity,
            child: Input(placeholder: "Full Name"),
          ),
          const SizedBox(
            height: 10.0,
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
            child: Input(placeholder: "Password"),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: ArgonColors.primary,
                    padding: const EdgeInsets.only(top: 15, bottom: 15)),
                child: const Text(
                  "Register",
                  style: TextStyle(color: ArgonColors.white),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Future(() {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    });
                  },
                  child: const Text(
                    'Login Here',
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
