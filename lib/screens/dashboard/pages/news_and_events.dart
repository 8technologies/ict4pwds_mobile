import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/news.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class NewsAndEvents extends StatefulWidget {
  const NewsAndEvents({Key? key}) : super(key: key);

  @override
  State<NewsAndEvents> createState() => _NewsAndEventsState();
}

class _NewsAndEventsState extends State<NewsAndEvents> {
  News news = News();
  Future<List<News>>? futureData;

  @override
  void initState() {
    futureData = news.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Column(
        children: <Widget>[
          const PageHeader(title: 'News and Events'),
          FutureBuilder<List<News>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<News>? data = snapshot.data;
                if (data!.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: Helpers.displayHeight(context) * 0.15),
                      const Image(
                        image: AssetImage("assets/img/dashboard/404.png"),
                        height: 100,
                      ),
                      const SizedBox(height: 15),
                      const Text("No Events found, check again later"),
                    ],
                  );
                }
                return Expanded(
                    child: ListView.builder(
                        padding:
                            MediaQuery.of(context).padding.copyWith(top: 2),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          String organiser = 'By: ${data[index].organiser}';
                          return InkWell(
                            onTap: () {},
                            child: GFCard(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              boxFit: BoxFit.cover,
                              titlePosition: GFPosition.start,
                              image: Image(
                                image: NetworkImage(data[index].coverImage!),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              showImage: true,
                              title: GFListTile(
                                avatar: const Icon(Icons.newspaper_rounded),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                titleText: data[index].title,
                                subTitleText:
                                    "Category: ${data[index].categoryName}",
                              ),
                              content: SizedBox(
                                width: double.infinity,
                                child: Text(organiser),
                              ),
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
