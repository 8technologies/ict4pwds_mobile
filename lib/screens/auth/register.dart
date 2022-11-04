import 'package:bootstrap_alert/bootstrap_alert.dart';
import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:ict4pwds_mobile/screens/auth/activate.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "No error";

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
                  "Create Account",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
            const SizedBox(
              height: 15.0,
            ),
            SizedBox(
                child: BootstrapAlert(
              visible: hasError,
              text: errorMessage,
              status: AlertStatus.danger,
            )),
            SizedBox(
              width: double.infinity,
              child: Input(
                  prefixIcon: const Icon(Icons.person),
                  placeholder: "Full Name",
                  controller: nameController,
                  validator: Helpers.validateFullName),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              child: Input(
                prefixIcon: const Icon(Icons.email),
                placeholder: "Email Address",
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
                  prefixIcon: const Icon(Icons.lock),
                  placeholder: "Password",
                  controller: passwordController,
                  validator: Helpers.validatePassword),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    registerFunction();
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
                          "Create Account",
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
                      Navigator.of(context).pop();
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
      ),
    ));
  }

  registerFunction() async {
    setState(() {
      hasError = false;
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      var createUser = await User.createUser(
          nameController.text, emailController.text, passwordController.text);

      if (createUser != "success") {
        setState(() {
          hasError = true;
          isLoading = false;
          errorMessage = createUser;
        });
        return;
      }

      Future(() {
        Route route = MaterialPageRoute(builder: (context) => const Activate());
        Navigator.pushReplacement(context, route);
      });

    }
    setState(() {
      isLoading = false;
    });
  }
}
