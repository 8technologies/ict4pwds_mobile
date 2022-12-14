import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:ict4pwds_mobile/screens/auth/login.dart';
import 'package:ict4pwds_mobile/screens/dashboard/tabs/settings/additional.dart';
import 'package:ict4pwds_mobile/screens/dashboard/tabs/settings/caregiver.dart';
import 'package:ict4pwds_mobile/screens/dashboard/tabs/settings/profile.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void getUser() async {
    var user = await User.getPrefUser();
    setState(() {
      if (user['profile_pic'] != null) {
        url = "${Config.baseUrl}${user['profile_pic']}";
      }
    });
  }

  String url = "default";

  bool loggingOut = false;
  EdgeInsets tilePadding =
      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12);
  EdgeInsets tileMarging =
      const EdgeInsets.symmetric(horizontal: 0, vertical: 2);

  @override
  void initState() {
    getUser();
    super.initState();
  }

  logout() async {
    setState(() {
      loggingOut = true;
    });
    await User.deleteUserToken();
    Future(() {
      var router = MaterialPageRoute(builder: (context) => const Login());
      Navigator.pushAndRemoveUntil(context, router, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Column(
        children: <Widget>[
          Container(
            color: ArgonColors.inputSuccess,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 35, left: 15, right: 15, bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  SizedBox(
                    child: Text(
                      "Account settings",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(child: Icon(Icons.settings)),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: MediaQuery.of(context).padding.copyWith(top: 2),
              children: <Widget>[
                GFListTile(
                  onTap: () {
                    var route = MaterialPageRoute(
                      builder: (context) => const Profile(),
                    );
                    Navigator.push(context, route);
                  },
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 12),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  color: ArgonColors.bgColorScreen,
                  avatar: url == 'default'
                      ? const GFAvatar(
                          backgroundColor: ArgonColors.white,
                          backgroundImage: AssetImage('assets/img/profile.png'),
                          size: GFSize.MEDIUM,
                        )
                      : GFAvatar(
                          backgroundColor: ArgonColors.white,
                          backgroundImage: NetworkImage(url),
                          size: GFSize.MEDIUM,
                        ),
                  titleText: "Account Information",
                  subTitleText: 'Update your account information',
                ),
                GFListTile(
                  onTap: () {
                    var route = MaterialPageRoute(
                      builder: (context) => const Additional(),
                    );
                    Navigator.push(context, route);
                  },
                  color: ArgonColors.bgColorScreen,
                  margin: tileMarging,
                  padding: tilePadding,
                  titleText: 'Personal Information',
                  subTitleText:
                      'Add your personal and bio data information here',
                  icon: const Icon(Icons.person_outline),
                ),
                GFListTile(
                  onTap: () {
                    var route = MaterialPageRoute(
                      builder: (context) => const CareGiver(),
                    );
                    Navigator.push(context, route);
                  },
                  color: ArgonColors.bgColorScreen,
                  margin: tileMarging,
                  padding: tilePadding,
                  titleText: 'Caregiver information',
                  subTitleText:
                      'Add information about your Next of kin, care taker and other information',
                  icon: const Icon(Icons.people_outline_outlined),
                ),
                GFListTile(
                    color: ArgonColors.bgColorScreen,
                    margin: tileMarging,
                    padding: tilePadding,
                    titleText: 'Privacy and Info',
                    subTitleText:
                        'Info about your data safety, data handling and privacy policy',
                    icon: const Icon(Icons.lock_outline)),
                GFListTile(
                    color: ArgonColors.bgColorScreen,
                    margin: tileMarging,
                    padding: tilePadding,
                    onTap: () {
                      logout();
                    },
                    titleText: 'Logout',
                    subTitleText: 'Sign out of your account',
                    icon: loggingOut
                        ? const CircularProgressIndicator(strokeWidth: 1)
                        : const Icon(Icons.logout_outlined)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
