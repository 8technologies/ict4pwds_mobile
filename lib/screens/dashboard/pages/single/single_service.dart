import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/service.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class SingleService extends StatefulWidget {
  const SingleService({Key? key, required this.service}) : super(key: key);
  final Service service;

  @override
  State<SingleService> createState() => _SingleServiceState();
}

class _SingleServiceState extends State<SingleService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            const PageHeader(title: "Provider Details"),
            Expanded(
              child: ListView(
                children: <Widget>[
                  GFListTile(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    avatar: widget.service.image == null
                    ? const GFAvatar(
                      backgroundImage: AssetImage('assets/img/empty.png'),
                    ) 
                    : GFAvatar(
                      backgroundImage: NetworkImage(widget.service.image!),
                    ),
                    title: Text(widget.service.name ?? "Provider Name",
                        style: const TextStyle(
                            color: ArgonColors.primary, fontSize: 16)),
                    subTitle: Text(
                      "Fee: ${widget.service.serviceFee!} UGX",
                      style: const TextStyle(color: ArgonColors.muted),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
