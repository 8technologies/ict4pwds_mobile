import 'package:flutter/material.dart';
import 'package:ict4pwds_mobile/constants/thems.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 35,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const<Widget>[
            SizedBox(
              height: 40,
              child: CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),)
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 6),
              child: SizedBox(
                height: 40,
                child: Text("Hello Ivan", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
              ),
            ),
          ],
        ),
        const SizedBox(width: double.infinity, child: Divider(color: ArgonColors.border,))
      ],
    );
  }
}
