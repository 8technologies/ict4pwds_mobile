import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/widgets/hometile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 45,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: SizedBox(
                height: 40,
                child: Text(
                  "Hello Ivan",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: SizedBox(
                  height: 35,
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://picsum.photos/id/237/200/300'),
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
                  titleText: "Services",
                  descriptionText: "Browser services and service providers",
                  onTap: () {}),
              HomeTile(
                  iconimage: "assets/img/dashboard/talk.png",
                  titleText: "Guidance and counselling",
                  descriptionText:
                      "Get access to currated counselling services",
                  onTap: () {}),
              HomeTile(
                  iconimage: "assets/img/dashboard/jobs.png",
                  titleText: "Jobs and Opportunities",
                  descriptionText:
                      "Browse and access job and employment opportunities",
                  onTap: () {}),
              HomeTile(
                  iconimage: "assets/img/dashboard/donate.png",
                  titleText: "Donante",
                  descriptionText: "Support or donate to a charity or cause",
                  onTap: () {}),
              HomeTile(
                  iconimage: "assets/img/dashboard/sport.png",
                  titleText: "Games and Sports",
                  descriptionText:
                      "Register to particapate in games and sports",
                  onTap: () {}),
              HomeTile(
                  iconimage: "assets/img/dashboard/speaker.png",
                  titleText: "Testimonies",
                  descriptionText:
                      "Share your stories and testimonies with the community",
                  onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
