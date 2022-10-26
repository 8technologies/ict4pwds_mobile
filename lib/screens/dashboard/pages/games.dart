import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/Game.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  Game game = Game();
  Future<List<Game>>? futureData;

  @override
  void initState() {
    futureData = game.fetchData();
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
            const PageHeader(title: 'Games and Sports'),
            FutureBuilder<List<Game>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Game>? data = snapshot.data;
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
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String title = data[index].gameName ?? 'Title';
                            String subtitle = 'At: ${data[index].venue}';
                            //String oppType = data[index].typeOfOffer ?? 'Free';
                            // String offerBy =
                            //     'By: ${data[index].nameOfProvider}';
                            // String category =
                            //     'category: ${data[index].opportunityCategory}';
                            return GFCard(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                              boxFit: BoxFit.cover,
                              titlePosition: GFPosition.start,
                              image: Image(
                                image: const NetworkImage(
                                    'https://via.placeholder.com/400'),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              showImage: true,
                              title: GFListTile(
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                margin: const EdgeInsets.symmetric(horizontal: 0),
                                titleText: title,
                                subTitleText: subtitle,
                              ),
                              content: const Text(
                                  "Some quick example text to build on the card"),
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
