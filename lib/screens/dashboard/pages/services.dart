import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/service.dart';
import 'package:ict4pwds_mobile/screens/dashboard/pages/single/single_service.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
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
      body: Column(
        children: <Widget>[
          const PageHeader(title: 'Service Providers'),
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
                      const Text("No Servies found, check again later"),
                    ],
                  );
                }
                return Expanded(
                    child: ListView.builder(
                        padding:
                            MediaQuery.of(context).padding.copyWith(top: 2),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          String url = data[index].image ?? "no_image";
                          return GFListTile(
                            onTap: () {
                              Service service = data[index];
                              var route = MaterialPageRoute(
                                builder: (context) => SingleService(
                                  service: service,
                                ),
                              );
                              Navigator.push(context, route);
                            },
                            color: ArgonColors.offwhite,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0.8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 12),
                            icon: const Icon(Icons.chevron_right),
                            avatar: url == "no_image"
                                ? const GFAvatar(
                                    backgroundImage:
                                        AssetImage('assets/img/empty.png'),
                                    shape: GFAvatarShape.standard)
                                : GFAvatar(
                                    backgroundImage: NetworkImage(url),
                                    shape: GFAvatarShape.standard),
                            title: Text(
                              data[index].name!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subTitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(Helpers.truncateString(
                                  data[index].description!, 50)),
                            ),
                          );
                        }));
              }
              return Padding(
                padding:
                    EdgeInsets.only(top: Helpers.displayHeight(context) * 0.15),
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
    );
  }
}
