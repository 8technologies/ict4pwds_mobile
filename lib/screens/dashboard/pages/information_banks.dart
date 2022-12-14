// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/information_bank.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';
import 'package:ict4pwds_mobile/widgets/styled_tile.dart';

class InformationBanks extends StatefulWidget {
  const InformationBanks({Key? key}) : super(key: key);

  @override
  State<InformationBanks> createState() => _InformationBanksState();
}

class _InformationBanksState extends State<InformationBanks> {
  InformationBank informationBank = InformationBank();
  Future<List<InformationBank>>? futureData;

  @override
  void initState() {
    futureData = informationBank.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Column(
        children: <Widget>[
          const PageHeader(title: 'Information Bank'),
          FutureBuilder<List<InformationBank>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<InformationBank>? data = snapshot.data;
                if (data!.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: Helpers.displayHeight(context) * 0.15),
                      const Image(
                        image: AssetImage("assets/img/dashboard/404.png"),
                        height: 100,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                          "No InformationBanks found, check again later"),
                    ],
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    padding: MediaQuery.of(context).padding.copyWith(top: 2),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StyledTile(
                        onTap: () {},
                        url: "no_image",
                        title:  data[index].title!,
                        subtitle: "Category: ${data[index].categoryName}"
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
