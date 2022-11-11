import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:ict4pwds_mobile/screens/auth/login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void getUser() async {
    var user = await User.getUserFromToken();
    setState(() {
      name = "${user['first_name']} ${user['last_name']}";
      if (user['profile_pic'] != null) {
        url = "${Config.baseUrl}${user['profile_pic']}";
      }
    });
  }

  String name = "Hello ";
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
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  SizedBox(
                      child: Text("Account settings",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600))),
                  SizedBox(child: Icon(Icons.settings)),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
              children: <Widget>[
                GFListTile(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 12),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                    color: ArgonColors.bgColorScreen,
                    avatar: url == 'default' 
                    ? const GFAvatar(
                      backgroundImage: AssetImage('assets/img/profile.png'),
                      size: GFSize.MEDIUM,
                    )
                    : GFAvatar(
                      backgroundImage: NetworkImage(url),
                      size: GFSize.MEDIUM,
                    ),
                    titleText: name,
                    subTitleText:
                        'Update you basic account information like email, phone etc',
                    icon: const Icon(Icons.person_outline)),
                GFListTile(
                    color: ArgonColors.bgColorScreen,
                    margin: tileMarging,
                    padding: tilePadding,
                    titleText: 'Additional Information',
                    subTitleText:
                        'Add information about your Next of kin, care taker and other information',
                    icon: const Icon(Icons.people_outline_outlined)),
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
            )),
          ],
        ),
      ),
    );
  }
}
