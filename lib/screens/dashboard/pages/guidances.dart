import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/Service.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class Guidencies extends StatefulWidget {
  const Guidencies({Key? key}) : super(key: key);

  @override
  State<Guidencies> createState() => _GuidenciesState();
}

class _GuidenciesState extends State<Guidencies> {
  Service service = Service();
  Future<List<Service>>? futureData;

  @override
  void initState() {
    futureData = service.fetchData();
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
            FutureBuilder<List<Service>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Service>? data = snapshot.data;
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
