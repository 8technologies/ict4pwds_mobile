import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';

class HomeTile extends StatelessWidget {
  final String iconimage;
  final String titleText;
  final String descriptionText;
  final Function()? onTap;

  const HomeTile(
      {super.key,
      required this.iconimage,
      required this.titleText,
      required this.descriptionText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      onTap: onTap,
      color: ArgonColors.offwhite,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.8),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      avatar: Image(image: AssetImage(iconimage), width: 40, height: 40),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 3, left: 5),
        child: Text(titleText,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      description: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(descriptionText, style: const TextStyle(fontSize: 12)),
      ),
      icon: const Icon(Icons.chevron_right),
    );
  }
}
