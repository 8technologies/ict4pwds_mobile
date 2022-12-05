import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/guidance.dart';
import 'package:ict4pwds_mobile/screens/dashboard/pages/single/single_guidance.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';
import 'package:ict4pwds_mobile/widgets/styled_tile.dart';

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
                        //String caption = "${data[index].serviceFee} UGX";
                        return StyledTile(
                          onTap: () {
                            Guidance guidance = data[index];
                            var route = MaterialPageRoute(
                              builder: (context) => SingleGuidance(
                                guidance: guidance,
                              ),
                            );
                            Navigator.push(context, route);
                          },
                          url: data[index].image ?? "no_image",
                          title: data[index].centerName ?? 'default',
                          subtitle: data[index].location ?? 'default',
                          //caption: caption,
                        );
                      },
                    ),
                  );
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
