import 'dart:convert';

import 'package:bootstrap_alert/bootstrap_alert.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/pwd.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';
import 'package:ict4pwds_mobile/widgets/select.dart';

class Additional extends StatefulWidget {
  const Additional({Key? key}) : super(key: key);

  @override
  State<Additional> createState() => _AdditionalState();
}

class _AdditionalState extends State<Additional> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dobController = TextEditingController();

  // final SingleValueDropDownController regionController =
  //     SingleValueDropDownController();
  final SingleValueDropDownController districtController =
      SingleValueDropDownController();
  final SingleValueDropDownController disabilityController =
      SingleValueDropDownController();
  final SingleValueDropDownController employmentController =
      SingleValueDropDownController();
  final SingleValueDropDownController educationLevelController =
      SingleValueDropDownController();

  final DropDownValueModel noMatch = const DropDownValueModel(
    name: 'Select item',
    value: null,
  );

  final List<DropDownValueModel> employmentStatusList = const [
    DropDownValueModel(name: 'Unemployed', value: 'Unemployed'),
    DropDownValueModel(name: 'Employed', value: 'Employed')
  ];

  final EdgeInsets labelPadding = const EdgeInsets.only(top: 15, bottom: 5);

  int? id;
  int? activeUser;
  dynamic activeProfile;
  List<DropDownValueModel> educLevelList = const [];
  List<DropDownValueModel> districtList = const [];
  List<DropDownValueModel> disabilitiesList = const [];

  bool isLoading = false;
  bool hasError = false;
  bool distEnabled = false;
  String errorMessage = "No error";

  Future getPwdProfile() async {
    var pwd = await Pwd.getPrefProfile();
    var user = await User.getUserFromToken();
    setState(() {
      activeUser = user;
      activeProfile = pwd;
      id = pwd['id'];
      if (id != null) {
        dobController.text = pwd['date_of_birth'];
      }
    });
  }

  void getselectLists() async {
    await getPwdProfile();
    var districts = Pwd.getDistrict().then(
      (value) => {
        setState(
          () => {
            districtList = List<DropDownValueModel>.from(
              value.map(
                (item) => DropDownValueModel(
                  name: item['name'],
                  value: item['id'],
                ),
              ),
            ),
          },
        )
      },
    );

    var educ = Pwd.getEduactionLevels().then(
      (value) => {
        setState(
          () => {
            educLevelList = List<DropDownValueModel>.from(
              value.map(
                (item) => DropDownValueModel(
                    name: item['name'],
                    value: item['id'],
                    toolTipMsg: item['region'].toString()),
              ),
            ),
          },
        )
      },
    );

    var dis = Pwd.getDisabilities().then(
      (value) => {
        setState(
          () => {
            disabilitiesList = List<DropDownValueModel>.from(
              value.map(
                (item) => DropDownValueModel(
                  name: item['name'],
                  value: item['id'],
                ),
              ),
            ),
          },
        )
      },
    );

    DropDownValueModel empStatus = employmentStatusList.firstWhere(
      (element) => element.value == activeProfile['employment_status'],
      orElse: () => noMatch,
    );
    if (empStatus.value != null) {
      employmentController.dropDownValue = empStatus;
    }

    await educ;
    DropDownValueModel educStatus = educLevelList.firstWhere(
      (element) => element.name == activeProfile['highest_level_of_education'],
      orElse: () => noMatch,
    );
    if (educStatus.value != null) {
      educationLevelController.dropDownValue = educStatus;
    }

    await dis;
    DropDownValueModel disStatus = disabilitiesList.firstWhere(
      (element) => element.name == activeProfile['type_of_disability'][0],
      orElse: () => noMatch,
    );
    if (disStatus.value != null) {
      disabilityController.dropDownValue = disStatus;
    }

    await districts;
    DropDownValueModel districtStatus = districtList.firstWhere(
      (element) => element.name == activeProfile['district'],
      orElse: () => noMatch,
    );
    if (districtStatus.value != null) {
      districtController.dropDownValue = districtStatus;
    }
  }

  @override
  void initState() {
    getselectLists();
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
          const PageHeader(title: 'Personal Information'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
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
                            child: Text("Type of Disability"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: disabilitiesList.isNotEmpty
                              ? Select(
                                  controller: disabilityController,
                                  dropDownList: disabilitiesList,
                                  validator: Helpers.validateText,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: LinearProgressIndicator(
                                    color: ArgonColors.muted,
                                  ),
                                ),
                        ),
                        Padding(
                          padding: labelPadding,
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text("Date of bith"),
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
                        Padding(
                          padding: labelPadding,
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text("District"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: districtList.isNotEmpty
                              ? Select(
                                  searchEnabled: true,
                                  validator: Helpers.validateText,
                                  readOnly: false,
                                  dropDownList: districtList,
                                  controller: districtController,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: LinearProgressIndicator(
                                    color: ArgonColors.muted,
                                  ),
                                ),
                        ),
                        Padding(
                          padding: labelPadding,
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text("Education Level"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: educLevelList.isNotEmpty
                              ? Select(
                                  dropDownList: educLevelList,
                                  controller: educationLevelController,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: LinearProgressIndicator(
                                    color: ArgonColors.muted,
                                  ),
                                ),
                        ),
                        Padding(
                          padding: labelPadding,
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text("Emplyoment status"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Select(
                            controller: employmentController,
                            dropDownList: employmentStatusList,
                            validator: Helpers.validateText,
                          ),
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
                                  top: 15,
                                  bottom: 15,
                                ),
                              ),
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
    //FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      hasError = false;
      isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      Map data = {
        "user": activeUser!,
        "type_of_disability": [disabilityController.dropDownValue?.value],
        "employment_status": employmentController.dropDownValue?.value,
        "district": districtController.dropDownValue?.value,
        "district_name": districtController.dropDownValue?.name,
      };

      if (dobController.text.isNotEmpty) {
        data["date_of_birth"] = dobController.text;
      }

      if (educationLevelController.dropDownValue?.value != null) {
        data["highest_level_of_education"] =
            educationLevelController.dropDownValue?.value;
      }

      dynamic profile;
      var payload = jsonEncode(data);
      if (id == null) {
        profile = await Pwd.createProfile(payload);
        errorMessage = "You profile has been created";
      } else {
        profile = await Pwd.upDateProfile(payload, id!);
        errorMessage = "Profile information updated";
      }

      if (profile != "success") {
        setState(() {
          hasError = true;
          isLoading = false;
          errorMessage = profile;
        });
        return;
      }

      var newProfile = await Pwd.getProfile(activeUser!);
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
