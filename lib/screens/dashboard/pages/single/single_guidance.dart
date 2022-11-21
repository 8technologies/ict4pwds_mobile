import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/guidance.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class SingleGuidance extends StatefulWidget {
  const SingleGuidance({Key? key, required this.guidance}) : super(key: key);
  final Guidance guidance;

  @override
  State<SingleGuidance> createState() => _SingleGuidanceState();
}

class _SingleGuidanceState extends State<SingleGuidance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            const PageHeader(title: "Guidance Details"),
            Expanded(
              child: ListView(
                children: const <Widget>[

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
