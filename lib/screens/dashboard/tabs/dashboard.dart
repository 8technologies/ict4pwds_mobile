import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:ict4pwds_mobile/screens/dashboard/pages/guidances.dart';
import 'package:ict4pwds_mobile/screens/dashboard/pages/news_and_events.dart';
import 'package:ict4pwds_mobile/screens/dashboard/pages/opportunities.dart';
import 'package:ict4pwds_mobile/screens/dashboard/pages/services.dart';
import 'package:ict4pwds_mobile/widgets/hometile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void getUser() async {
    var user = await User.getUserFromToken();
    setState(() {
      name = "Hello ${user['first_name']}";
      if (user['profile_pic'] != null) {
        url = "${Config.baseUrl}${user['profile_pic']}";
      }
    });
  }

  String name = "Hello ";
  String url = "default";

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 22),
              child: SizedBox(
                height: 40,
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SizedBox(
                  height: 35,
                  child: url == 'default'
                      ? const CircleAvatar(
                          backgroundImage: AssetImage('assets/img/profile.png'),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(url),
                        )),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Text(
            "Welcome to ICT4PWD, Choose any service from the list below",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              HomeTile(
                iconimage: "assets/img/dashboard/services.png",
                titleText: "Service Providers",
                descriptionText: "Browse services and service providers",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Services()));
                },
              ),
              HomeTile(
                iconimage: "assets/img/dashboard/talk.png",
                titleText: "Guidance and counselling",
                descriptionText:
                    "Get access to guidance and counseling services",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Guidencies()));
                },
              ),
              HomeTile(
                  iconimage: "assets/img/dashboard/jobs.png",
                  titleText: "Jobs and Opportunities",
                  descriptionText:
                      "Browse and access job and employment opportunities",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Opportunities()));
                  }),
              HomeTile(
                iconimage: "assets/img/dashboard/news.png",
                titleText: "News and Events",
                descriptionText:
                    "Get the latest updates and events from different providers and organisations",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewsAndEvents()));
                },
              ),
              HomeTile(
                iconimage: "assets/img/dashboard/info.png",
                titleText: "Information Bank",
                descriptionText:
                    "Access information, publications and other useful resources",
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
