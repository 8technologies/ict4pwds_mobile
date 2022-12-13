import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';

class PageHeader extends StatelessWidget {
  final String title;

  const PageHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ArgonColors.inputSuccess,
      child: Padding(
        padding: const EdgeInsets.only(top: 35, left: 15, bottom: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: ArgonColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ArgonColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
