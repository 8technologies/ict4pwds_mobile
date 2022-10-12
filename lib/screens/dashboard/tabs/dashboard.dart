import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';

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
        Expanded(
          child: ListView(
            children: <Widget>[
              GFListTile(
                color: ArgonColors.offwhite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                enabled: true,
                onTap: () {},
                avatar: const GFAvatar(
                  backgroundImage:
                      NetworkImage("https://picsum.photos/id/237/200/300"),
                ),
                titleText: 'Services',
                description: const Text(
                    'Browser services and service providers',
                    style: TextStyle(fontSize: 12)),
                icon: const Icon(Icons.chevron_right),
              ),
              GFListTile(
                color: ArgonColors.offwhite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                enabled: true,
                onTap: () {},
                avatar: const GFAvatar(
                  backgroundImage:
                      NetworkImage("https://picsum.photos/id/237/200/300"),
                ),
                titleText: 'Guidance and counselling',
                description: const Text(
                    'Get access to currated counselling services',
                    style: TextStyle(fontSize: 12)),
                icon: const Icon(Icons.chevron_right),
              ),
              GFListTile(
                color: ArgonColors.offwhite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                enabled: true,
                onTap: () {},
                avatar: const GFAvatar(
                  backgroundImage:
                      NetworkImage("https://picsum.photos/id/237/200/300"),
                ),
                titleText: 'Jobs and Opportunities',
                description: const Text(
                    'Browse and access job and employment opportunities',
                    style: TextStyle(fontSize: 12)),
                icon: const Icon(Icons.chevron_right),
              ),
              GFListTile(
                color: ArgonColors.offwhite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                enabled: true,
                onTap: () {},
                avatar: const GFAvatar(
                  backgroundImage:
                      NetworkImage("https://picsum.photos/id/237/200/300"),
                ),
                titleText: 'Donate',
                description: const Text(
                    'Support or donate to a charity or cause',
                    style: TextStyle(fontSize: 12)),
                icon: const Icon(Icons.chevron_right),
              ),
              GFListTile(
                color: ArgonColors.offwhite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                enabled: true,
                onTap: () {},
                avatar: const GFAvatar(
                  backgroundImage:
                      NetworkImage("https://picsum.photos/id/237/200/300"),
                ),
                titleText: 'Games and Sports',
                description: const Text(
                    'Register to particapate in games and sports',
                    style: TextStyle(fontSize: 12)),
                icon: const Icon(Icons.chevron_right),
              ),
              GFListTile(
                color: ArgonColors.offwhite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.5),
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                enabled: true,
                onTap: () {},
                avatar: const GFAvatar(
                  backgroundImage:
                      NetworkImage("https://picsum.photos/id/237/200/300"),
                ),
                titleText: 'Testimonies',
                description: const Text(
                    'Share your stories and testimonies with the community',
                    style: TextStyle(fontSize: 12)),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
