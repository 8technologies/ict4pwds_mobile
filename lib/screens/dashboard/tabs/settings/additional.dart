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
  //final SingleValueDropDownController _cnt = SingleValueDropDownController();

  final List<DropDownValueModel> hasCareTakerList = const [
    DropDownValueModel(name: 'Yes', value: true),
    DropDownValueModel(name: 'No', value: false)
  ];

  final List<DropDownValueModel> employmentStatusList = const [
    DropDownValueModel(name: 'Unemployed', value: 'Unemployed'),
    DropDownValueModel(name: 'Employed', value: 'Employed')
  ];

  int? id;
  List<DropDownValueModel> educLevelList = const [];
  List<DropDownValueModel> disabilitiesList = const [];

  void getPwdProfile() async {
    var pwd = await Pwd.getPrefProfile();
    setState(() {
      id = pwd['id'];
    });
  }

  void getselectLists() async {
    Pwd.getEduactionLevels().then(
      (value) => {
        setState(
          () => {
            educLevelList = List<DropDownValueModel>.from(
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

    Pwd.getDisabilities().then(
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
  }

  @override
  void initState() {
    getPwdProfile();
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
                        const SizedBox(
                          width: double.infinity,
                          child: Text("Type of Disability"),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: disabilitiesList.isNotEmpty
                              ? Select(dropDownList: disabilitiesList)
                              : const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: LinearProgressIndicator(
                                    color: ArgonColors.muted,
                                  ),
                                ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
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
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Region"),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Enter your region here",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("District"),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Enter your district",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Education Level"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: educLevelList.isNotEmpty
                              ? Select(dropDownList: educLevelList)
                              : const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: LinearProgressIndicator(
                                    color: ArgonColors.muted,
                                  ),
                                ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Emplyoment status"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Select(dropDownList: employmentStatusList),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Do you have a caregiver"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Select(dropDownList: hasCareTakerList),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 25),
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

  updateProfile() async {}

  createProfile() async {}

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
