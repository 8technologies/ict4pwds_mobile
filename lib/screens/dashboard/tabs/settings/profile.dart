import 'dart:io';
import 'package:bootstrap_alert/bootstrap_alert.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:ict4pwds_mobile/widgets/input.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "No error";

  Future getImage(ImageSource media) async {
    final img = await picker.pickImage(source: media);
    if (img != null) {
      setState(() {
        imageFile = img;
      });
    }
  }

  String image = "default";
  int? id;

  void getUser() async {
    var user = await User.getPrefUser();
    setState(() {
      id = user['id'];
      if (user['profile_pic'] != null) {
        image = "${Config.baseUrl}${user['profile_pic']}";
      }

      if (user['first_name'] != null && user['last_name'] != null) {
        nameController.text = "${user['first_name']} ${user['last_name']}";
      }
      emailController.text = user['email'];
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Column(
        children: <Widget>[
          const PageHeader(title: 'Update Account Info'),
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              child: _buildImage(),
                            ),
                            SizedBox(
                              child: TextButton(
                                onPressed: () async {
                                  await getImage(ImageSource.gallery);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: ArgonColors.muted,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                ),
                                child: const Text(
                                  "Select Image",
                                  style: TextStyle(color: ArgonColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Fullname"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Input(
                            placeholder: "Fullname",
                            controller: nameController,
                            validator: Helpers.validateFullName,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Phone Number"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Input(
                            controller: phoneController,
                            placeholder: "E.g 256701234567",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Email Address"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Input(
                            readOnly: true,
                            controller: emailController,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  updateProfile();
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

  Widget _buildImage() {
    if (imageFile != null) {
      return GFAvatar(
        backgroundColor: ArgonColors.white,
        size: GFSize.LARGE,
        child: Image.file(File(imageFile!.path)),
      );
      ;
    }

    if (image == 'default') {
      return const GFAvatar(
        backgroundColor: ArgonColors.white,
        backgroundImage: AssetImage('assets/img/profile.png'),
        size: GFSize.LARGE,
      );
    } else {
      return GFAvatar(
        backgroundColor: ArgonColors.white,
        backgroundImage: NetworkImage(image),
        size: GFSize.LARGE,
      );
    }
  }

  updateProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      hasError = false;
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      var createUser = await User.upDateProfile(
        id!,
        nameController.text,
        emailController.text,
      );

      if (createUser != "success") {
        setState(() {
          hasError = true;
          isLoading = false;
          errorMessage = createUser;
        });
        return;
      }
    }

    var user = await User.getUserProfile(id!);
    if (user) {
      setState(() {
        hasError = true;
        isLoading = false;
        errorMessage = "Information updated";
      });
    }
  }
}
