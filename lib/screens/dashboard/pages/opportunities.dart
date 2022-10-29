import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/opportunity.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class Opportunities extends StatefulWidget {
  const Opportunities({Key? key}) : super(key: key);

  @override
  State<Opportunities> createState() => _OpportunitiesState();
}

class _OpportunitiesState extends State<Opportunities> {
  Opportunity opportunity = Opportunity();
  Future<List<Opportunity>>? futureData;

  @override
  void initState() {
    futureData = opportunity.fetchData();
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
            const PageHeader(title: 'Jobs and Opportunities'),
            FutureBuilder<List<Opportunity>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Opportunity>? data = snapshot.data;
                  if (data!.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: Helpers.displayHeight(context) * 0.15),
                        const Image(
                          image: AssetImage("assets/img/dashboard/404.png"),
                          height: 100,
                        ),
                        const SizedBox(height: 15),
                        const Text("No Opportunities found, check again later"),
                      ],
                    );
                  }
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String oppTitle =
                                data[index].opportunityTitle ?? 'default';
                            String oppDescription =
                                data[index].description ?? 'default';
                            String oppType = data[index].typeOfOffer ?? 'Free';
                            String offerBy =
                                'By: ${data[index].nameOfProvider}';
                            String category =
                                'category: ${data[index].opportunityCategory}';
                            return GFListTile(
                              color: ArgonColors.offwhite,
                              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.8),
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                              avatar: const GFAvatar(
                                  backgroundImage: NetworkImage('http://23.29.118.237/uploads/2.jpg'),
                                  shape: GFAvatarShape.standard),
                              title: Text(
                                oppTitle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subTitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(offerBy),
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(oppType,
                                    style: const TextStyle(
                                        color: ArgonColors.primary,
                                        fontWeight: FontWeight.bold)),
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
