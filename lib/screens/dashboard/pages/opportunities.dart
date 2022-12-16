
import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/opportunity.dart';
import 'package:ict4pwds_mobile/screens/dashboard/pages/single/single_opportunity.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';
import 'package:ict4pwds_mobile/widgets/styled_tile.dart';

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
      body: Column(
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
                    padding: MediaQuery.of(context).padding.copyWith(top: 2),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StyledTile(
                        onTap: () {
                          Opportunity opportunity = data[index];
                          var route = MaterialPageRoute(
                            builder: (context) =>
                                SingleOpportunity(opportunity: opportunity),
                          );
                          Navigator.push(context, route);
                        },
                        url: data[index].logo ?? "no_image",
                        title: data[index].opportunityTitle ?? "No title",
                        subtitle: data[index].nameOfProvider ??
                            "Opportunity Offered By",
                      );
                    },
                  ),
                );
              }
              return Padding(
                padding:
                    EdgeInsets.only(top: Helpers.displayHeight(context) * 0.15),
                child: const SizedBox(
                  height: 35,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: ArgonColors.primary,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
