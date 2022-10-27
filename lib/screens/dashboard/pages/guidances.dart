import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/guidance.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';
import 'package:ict4pwds_mobile/widgets/styledTile.dart';

class Guidencies extends StatefulWidget {
  const Guidencies({Key? key}) : super(key: key);

  @override
  State<Guidencies> createState() => _GuidenciesState();
}

class _GuidenciesState extends State<Guidencies> {
  Guidance guidance = Guidance();
  Future<List<Guidance>>? futureData;

  @override
  void initState() {
    futureData = guidance.fetchData();
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
            const PageHeader(title: 'Guidance and counseling'),
            FutureBuilder<List<Guidance>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Guidance>? data = snapshot.data;
                  if (data!.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: Helpers.displayHeight(context) * 0.15),
                        const Image(
                          image: AssetImage("assets/img/dashboard/404.png"),
                          height: 100,
                        ),
                        const SizedBox(height: 15),
                        const Text("No results found, check again later"),
                      ],
                    );
                  }
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String title = data[index].centerName ?? 'default';
                            String subtitle = data[index].location ?? 'default';
                            String caption = "${data[index].serviceFee} UGX";
                            return StyledTile(
                                onTap: () {},
                                title: title,
                                subtitle: subtitle,
                                caption: caption);
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
