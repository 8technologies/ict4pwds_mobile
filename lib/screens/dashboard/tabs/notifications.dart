import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/user_notification.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  UserNotification userNotification = UserNotification();
  Future<List<UserNotification>>? futureData;

  @override
  void initState() {
    futureData = userNotification.fetchData();
    super.initState();
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
                  top: 20, left: 15, right: 15, bottom: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  SizedBox(
                      child: Text("Notifications",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600))),
                  SizedBox(child: Icon(Icons.notifications)),
                ],
              ),
            ),
            FutureBuilder<List<UserNotification>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserNotification>? data = snapshot.data;
                  if (data!.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: Helpers.displayHeight(context) * 0.15),
                        const Image(
                          image: AssetImage("assets/img/dashboard/404.png"),
                          height: 100,
                        ),
                        const SizedBox(height: 15),
                        const Text("You do not have any notifications"),
                      ],
                    );
                  }
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String title = data[index].message ?? 'Title';
                            String subtitle = 'At: ${data[index].category}';
                            //String oppType = data[index].typeOfOffer ?? 'Free';
                            // String offerBy =
                            //     'By: ${data[index].nameOfProvider}';
                            // String category =
                            //     'category: ${data[index].opportunityCategory}';
                            return GFCard(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              boxFit: BoxFit.cover,
                              titlePosition: GFPosition.start,
                              image: Image(
                                image: const NetworkImage(
                                    'http://23.29.118.237/uploads/2.jpg'),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              showImage: true,
                              title: GFListTile(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                titleText: title,
                                subTitleText: subtitle,
                              ),
                              content: SizedBox(
                                width: double.infinity,
                                child: Text(Helpers.truncateString(
                                    "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                                    100)),
                              ),
                            );
                          }));
                }
                return Padding(
                  padding: EdgeInsets.only(
                      top: Helpers.displayHeight(context) * 0.15),
                  child: const SizedBox(
                      height: 35,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: ArgonColors.primary,
                      )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
