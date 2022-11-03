import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:ict4pwds_mobile/screens/dashboard/home.dart';
import 'package:bootstrap_alert/bootstrap_alert.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool authPassed = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
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
            SizedBox(
                child: BootstrapAlert(
              visible: authPassed,
              text: 'User Authentication failed',
              status: AlertStatus.danger,
            )),
            SizedBox(
              width: double.infinity,
              child: Input(
                placeholder: "Email Address",
                prefixIcon: const Icon(Icons.email),
                controller: emailController,
                validator: Helpers.validateEmail,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              child: Input(
                placeholder: "Password",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock),
                controller: passwordController,
                validator: Helpers.validatePassword,
              ),
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
                  child: isLoading
                      ? const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: ArgonColors.white,
                            strokeWidth: 1,
                          ))
                      : const Text(
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
                      Navigator.pushNamed(context, "/register");
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
      ),
    ));
  }

  loginFunction() async {
    setState(() {
      authPassed = false;
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      var authed =
          await User.authUser(emailController.text, passwordController.text);

      if (authed == false) {
        setState(() {
          authPassed = true;
          isLoading = false;
        });
        return;
      }

      Future(() {
        var router = MaterialPageRoute(builder: (context) => const Home());
        Navigator.pushAndRemoveUntil(context, router, (route) => false);
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
