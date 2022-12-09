import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
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

  XFile? _image;
  final picker = ImagePicker();

  void getUser() async {
    var user = await User.getUserFromToken();
    setState(() {
      if (user['profile_pic'] != null) {
        image = "${Config.baseUrl}${user['profile_pic']}";
      }
    });
  }

  String image = "default";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            const PageHeader(title: 'User Profile'),
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                child: _buildImage(),
                              ),
                              SizedBox(
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor: ArgonColors.muted,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
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
                            padding: EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text("Fullname"),
                            ),
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Input(
                              placeholder: "Fullname",
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text("Phone Number"),
                            ),
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Input(
                              placeholder: "Phone Number",
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text("Email Address"),
                            ),
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Input(
                              placeholder: "Email Address",
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
      ),
    );
  }

  Widget _buildImage() {
    if (image == 'default') {
      return const GFAvatar(
        backgroundImage: AssetImage('assets/img/profile.png'),
        size: GFSize.MEDIUM,
      );
    } else {
      return GFAvatar(
        backgroundImage: NetworkImage(image),
        size: GFSize.MEDIUM,
      );
    }
  }
}
