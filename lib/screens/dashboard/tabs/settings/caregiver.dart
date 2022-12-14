import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class CareGiver extends StatefulWidget {
  const CareGiver({Key? key}) : super(key: key);

  @override
  State<CareGiver> createState() => _CareGiverState();
}

class _CareGiverState extends State<CareGiver> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Column(
        children: <Widget>[
          const PageHeader(title: 'Caregiver Information'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          width: double.infinity,
                          child: Text("Next of Kin"),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Next Of Kin",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Next of Kin Relationship"),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Next of Kin Relationship",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Next of Kin Number"),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Next of Kin Number",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Name of care taker"),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Name of care taker",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Care taker phone number"),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Care taker phone number",
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor: ArgonColors.primary,
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15)),
                                child: const Text(
                                  "Update Information",
                                  style: TextStyle(color: ArgonColors.white),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
