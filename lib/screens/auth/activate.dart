import 'package:flutter/material.dart';

class Activate extends StatefulWidget {
  const Activate({Key? key}) : super(key: key);

  @override
  State<Activate> createState() => _ActivateState();
}

class _ActivateState extends State<Activate> {
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
            height: 20.0,
          ),
          const SizedBox(
              width: double.infinity,
              child: Text(
                "Activate Account",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              )),
          const SizedBox(
            height: 18.0,
          ),
          const SizedBox(
            width: double.infinity,
            child: Text(
              style: TextStyle(fontSize: 16.0),
                "Thank you for creating an account. An account activation link has been sent to your email address, check your email to activate account and then login to start using the app."
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    style: TextStyle(fontSize: 16.0),
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
