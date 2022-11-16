import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';

class StyledTile extends StatelessWidget {
  final String url;
  final String title;
  final String subtitle;
  //final String caption;
  final Function()? onTap;

  const StyledTile({
    super.key,
    required this.onTap,
    required this.url,
    required this.title,
    required this.subtitle,
    //required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      onTap: onTap,
      color: ArgonColors.offwhite,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.8),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      avatar: url == "no_image"
          ? const GFAvatar(
              backgroundImage: AssetImage('assets/img/empty.png'),
              shape: GFAvatarShape.standard,
            )
          : GFAvatar(
              backgroundImage: NetworkImage(url),
              shape: GFAvatarShape.standard,
            ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subTitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(subtitle),
      ),
      // icon: Padding(
      //   padding: const EdgeInsets.only(top: 20),
      //   child: Text(
      //     caption,
      //     style: const TextStyle(
      //         color: ArgonColors.primary, fontWeight: FontWeight.bold),
      //   ),
      // ),
      icon: const Icon(Icons.chevron_right),
    );
  }
}
