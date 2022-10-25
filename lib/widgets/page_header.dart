import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';

class PageHeader extends StatelessWidget {
  final String title;

  const PageHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: SizedBox(
              height: 40,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:
                      const Icon(Icons.arrow_back, color: ArgonColors.black))),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 22),
          child: SizedBox(
            height: 40,
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
