import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/opportunity.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';
import 'package:flutter_html/flutter_html.dart';

class SingleOpportunity extends StatefulWidget {
  const SingleOpportunity({Key? key, required this.opportunity})
      : super(key: key);
  final Opportunity opportunity;

  @override
  State<SingleOpportunity> createState() => _SingleOpportunityState();
}

class _SingleOpportunityState extends State<SingleOpportunity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            const PageHeader(title: "Opportunity Details"),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GFListTile(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20),
                    avatar: GFAvatar(
                        backgroundImage:
                            NetworkImage(widget.opportunity.logo!)),
                    title: Text(widget.opportunity.opportunityTitle!,
                        style: const TextStyle(
                            color: ArgonColors.primary, fontSize: 16)),
                    subTitle: Text(
                      "By ${widget.opportunity.nameOfProvider!}",
                      style: const TextStyle(color: ArgonColors.muted),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Html(data: widget.opportunity.description),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
