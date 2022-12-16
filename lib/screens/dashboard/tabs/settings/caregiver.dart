import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';
import 'package:ict4pwds_mobile/widgets/select.dart';
import 'package:intl/intl.dart';

class CareGiver extends StatefulWidget {
  const CareGiver({Key? key}) : super(key: key);

  @override
  State<CareGiver> createState() => _CareGiverState();
}

class _CareGiverState extends State<CareGiver> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dobController = TextEditingController();

  final List<DropDownValueModel> genderList = const [
    DropDownValueModel(name: 'Yes', value: true),
    DropDownValueModel(name: 'No', value: false)
  ];

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
                          child: Text("Name of Caregiver"),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Name of Caregiver",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Gender of Caregiver"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Select(dropDownList: genderList),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Phone number of Caregive"),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "e.g 256701234567",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Caregiver date of birth"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Input(
                            readOnly: true,
                            prefixIcon: const Icon(Icons.calendar_today),
                            placeholder: "1990-01-30",
                            controller: dobController,
                            onTap: () {
                              selectDate();
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Relationship to caregiver"),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Relationship to caregiver",
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor: ArgonColors.mainGreen,
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15)),
                                child: const Text(
                                  "Update Information",
                                  style: TextStyle(color: ArgonColors.black),
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

  selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dobController.text = formattedDate;
      });
    }
  }
}
