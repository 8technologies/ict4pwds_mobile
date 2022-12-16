import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:bootstrap_alert/bootstrap_alert.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';

class ConfirmReset extends StatefulWidget {
  const ConfirmReset({Key? key}) : super(key: key);

  @override
  State<ConfirmReset> createState() => _ConfirmResetState();
}

class _ConfirmResetState extends State<ConfirmReset> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool authPassed = false;
  bool isLoading = false;
  String errorMessage = "No error";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ArgonColors.white,
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
                        image: AssetImage('assets/img/logo2.png'),
                        height: 90,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Set new password",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  child: BootstrapAlert(
                    visible: authPassed,
                    text: errorMessage,
                    status: AlertStatus.danger,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                      "Enter the token sent to your email and a new password"),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Input(
                    placeholder: "Password reset token",
                    prefixIcon: const Icon(Icons.key),
                    controller: tokenController,
                    validator: Helpers.validateText,
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
                      confirmResetFunction();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: ArgonColors.mainGreen,
                        padding: const EdgeInsets.only(top: 15, bottom: 15)),
                    child: isLoading
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              color: ArgonColors.black,
                              strokeWidth: 1,
                            ),
                          )
                        : const Text(
                            "Reset Password",
                            style: TextStyle(color: ArgonColors.black),
                          ),
                  ),
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
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Back to Login',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  confirmResetFunction() async {
    setState(() {
      authPassed = false;
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      var authed = await User.confirmPWReset(
        passwordController.text,
        tokenController.text,
      );

      if (authed != "success") {
        setState(() {
          authPassed = true;
          isLoading = false;
          errorMessage = authed;
        });
        return;
      }

      Future(() {
        Navigator.of(context).pop();
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
