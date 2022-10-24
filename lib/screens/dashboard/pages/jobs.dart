import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/opportunities.dart';

class Job extends StatefulWidget {
  const Job({Key? key}) : super(key: key);

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                      height: 40,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back,
                              color: ArgonColors.black))),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5, top: 22),
                  child: SizedBox(
                    height: 40,
                    child: Text(
                      "Jobs and Opportunities",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
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
                            return Card(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  trailing: const Icon(Icons.chevron_right),
                                  title: Text(oppTitle),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(Helpers.truncateString("is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries", 100)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 3, bottom: 10),
                                      child: Text(offerBy),
                                    ),
                                  ),
                                )
                              ],
                            ));
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
