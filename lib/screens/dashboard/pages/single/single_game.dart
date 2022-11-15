import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:ict4pwds_mobile/constants/themes.dart';
import 'package:ict4pwds_mobile/models/game.dart';
import 'package:ict4pwds_mobile/widgets/page_header.dart';

class SingleGame extends StatefulWidget {
  const SingleGame({Key? key, required this.game}) : super(key: key);
  final Game game;

  @override
  State<SingleGame> createState() => _SingleGameState();
}

class _SingleGameState extends State<SingleGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            PageHeader(title: widget.game.gameName!),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Image(
                    image: NetworkImage(widget.game.coverImage!),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
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
