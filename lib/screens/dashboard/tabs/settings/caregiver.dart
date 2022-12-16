import 'dart:convert';

import 'package:bootstrap_alert/bootstrap_alert.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/navigation_service.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/pwd.dart';
import 'package:ict4pwds_mobile/screens/dashboard/tabs/settings/additional.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final SingleValueDropDownController genderController =
      SingleValueDropDownController();
  final SingleValueDropDownController hasCaregiverController =
      SingleValueDropDownController();

  final DropDownValueModel noMatch = const DropDownValueModel(
    name: 'Select item',
    value: null,
  );

  final List<DropDownValueModel> hasCareTakerList = const [
    DropDownValueModel(name: 'Yes', value: true),
    DropDownValueModel(name: 'No', value: false)
  ];

  final List<DropDownValueModel> genderList = const [
    DropDownValueModel(name: 'Yes', value: true),
    DropDownValueModel(name: 'No', value: false)
  ];

  final EdgeInsets labelPadding = const EdgeInsets.only(top: 15, bottom: 5);

  int? id;
  dynamic activeProfile;

  bool hasCaregiver = false;
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "No error";

  Future getPwdProfile() async {
    var pwd = await Pwd.getPrefProfile();
    setState(() {
      activeProfile = pwd;
      id = pwd['id'];
      if (id == null) {
        NavigationService().replaceScreen(const Additional());
      }
    });

    DropDownValueModel careGiver = hasCareTakerList.firstWhere(
      (element) => element.value == activeProfile['has_care_giver'],
      orElse: () => noMatch,
    );
    if (careGiver.value != null) {
      hasCaregiverController.dropDownValue = careGiver;
    }

    DropDownValueModel gender = genderList.firstWhere(
      (element) => element.value == activeProfile['care_giver_gender'],
      orElse: () => noMatch,
    );
    if (gender.value != null) {
      genderController.dropDownValue = gender;
    }

    nameController.text = activeProfile['care_giver_name'];
    dobController.text = activeProfile['care_giver_date_of_birth'];
    phoneController.text = activeProfile['care_giver_phone_number'];
    relationController.text = activeProfile['relationship_with_care_giver'];
  }

  @override
  void initState() {
    getPwdProfile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                        SizedBox(
                          child: BootstrapAlert(
                            visible: hasError,
                            text: errorMessage,
                            isDismissible: true,
                          ),
                        ),
                        Padding(
                          padding: labelPadding,
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text("Do you have a caregiver"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Select(
                            clearOption: false,
                            onChanged: (value) {
                              setState(() {
                                hasCaregiver = value.value;
                              });
                            },
                            validator: Helpers.validateText,
                            dropDownList: hasCareTakerList,
                            controller: hasCaregiverController,
                          ),
                        ),
                        hasCaregiver
                            ? Column(
                                children: [
                                  Padding(
                                    padding: labelPadding,
                                    child: const SizedBox(
                                      width: double.infinity,
                                      child: Text("Name of Caregiver"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Input(
                                      controller: nameController,
                                      placeholder: "Name of Caregiver",
                                      validator: Helpers.validateFullName,
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
                                    child: Select(
                                      dropDownList: genderList,
                                      controller: genderController,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 15),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text("Phone number of Caregive"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Input(
                                      controller: phoneController,
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
                                      prefixIcon:
                                          const Icon(Icons.calendar_today),
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
                                  SizedBox(
                                    width: double.infinity,
                                    child: Input(
                                      controller: relationController,
                                      placeholder: "Relationship to caregiver",
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(
                                height: 12,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                submitProfile();
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: ArgonColors.mainGreen,
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15)),
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
                                      "Update Information",
                                      style:
                                          TextStyle(color: ArgonColors.black),
                                    ),
                            ),
                          ),
                        ),
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

  submitProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      hasError = false;
      isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      Map data = {
        "type_of_disability": [activeProfile['type_of_disability'][0]],
        "has_care_giver": hasCaregiverController.dropDownValue?.value,
        "employment_status": activeProfile['employment_status']
      };

      if (hasCaregiver) {
        if (dobController.text.isNotEmpty) {
          data["date_of_birth"] = dobController.text;
        }

        if (genderController.dropDownValue?.value != null) {
          data["care_giver_gender"] = genderController.dropDownValue?.value;
        }

        if (nameController.text.isNotEmpty) {
          data["care_giver_name"] = nameController.text;
        }

        if (phoneController.text.isNotEmpty) {
          data["care_giver_phone_number"] = phoneController.text;
        }

        if (relationController.text.isNotEmpty) {
          data["relationship_with_care_giver"] = relationController.text;
        }
      }

      var payload = jsonEncode(data);

      var profile = await Pwd.upDateProfile(payload, id!);
      errorMessage = "Profile information updated";

      if (profile != "success") {
        setState(() {
          hasError = true;
          isLoading = false;
          errorMessage = profile;
        });
        return;
      }

      var newProfile = await Pwd.getProfile(activeProfile['user']);
      if (newProfile) {
        var pwd = await Pwd.getPrefProfile();
        setState(() {
          id = pwd['id'];
          hasError = true;
          errorMessage = errorMessage;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
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
