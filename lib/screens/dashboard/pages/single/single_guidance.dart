import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
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
      body: Column(
        children: [
          const PageHeader(title: "Guidance Details"),
          Expanded(
            child: ListView(
              children: <Widget>[
                GFListTile(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  avatar: widget.guidance.image == null
                      ? const GFAvatar(
                          backgroundImage: AssetImage('assets/img/empty.png'),
                        )
                      : GFAvatar(
                          backgroundImage:
                              NetworkImage(widget.guidance.image!),
                        ),
                  title: Text(widget.guidance.centerName!,
                      style: const TextStyle(
                          color: ArgonColors.primary, fontSize: 16)),
                  subTitle: Text(
                    "Service Fee: ${widget.guidance.serviceFee} UGX",
                    style: const TextStyle(color: ArgonColors.muted),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GFListTile(
                    description: Text(widget.guidance.servicesOffered!),
                  ),
                ),
                GFListTile(
                  avatar: const Icon(Icons.location_on),
                  title: Text(widget.guidance.location!),
                ),
                GFListTile(
                  avatar: const Icon(Icons.email),
                  title: Text(widget.guidance.emailAdress!),
                ),
                GFListTile(
                  avatar: const Icon(Icons.phone),
                  title: Text(widget.guidance.phoneNumber!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
