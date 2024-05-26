import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smriti/utils/theme.dart';

class Smriti extends StatelessWidget {
  const Smriti({super.key});

  @override
  Widget build(BuildContext context) {
    var data = "Lorem Ipsum";
    var data2 =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus in tincidunt justo.";
    var data3 = "#tag";
    return Scaffold(
      backgroundColor: SmritiTheme.background,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "${getGreeting()}, ",
                    style: GoogleFonts.lato(color: SmritiTheme.secondary),
                    children: [
                      TextSpan(
                          text: "User",
                          style: TextStyle(color: SmritiTheme.primary)),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_rounded,
                      color: SmritiTheme.primary,
                    ))
              ],
            ),
            Divider(),
            Center(
              child: Text(
                "aapki\n  smriti",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 70,
                      color: SmritiTheme.primary,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 12),
                      child: TagButton(tag: data3)),
                  Container(
                      margin: EdgeInsets.only(right: 12),
                      child: TagButton(tag: data3)),
                ],
              ),
            ),
            SmritiListTile(title: data, subTitle: data2),
            SmritiListTile(title: data, subTitle: data2),
          ],
        ),
      ),
    );
  }
}

class TagButton extends StatelessWidget {
  const TagButton({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          side: WidgetStateProperty.all(BorderSide(color: SmritiTheme.primary)),
          backgroundColor: WidgetStateProperty.all(SmritiTheme.background)),
      onPressed: () {},
      child: Text(
        tag,
        style: GoogleFonts.lato(fontSize: 22, color: SmritiTheme.primary),
      ),
    );
  }
}

class SmritiListTile extends StatelessWidget {
  const SmritiListTile({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(fontSize: 28, color: SmritiTheme.primary),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 16),
          child: Text(subTitle,
              maxLines: 2,
              style:
                  GoogleFonts.lato(fontSize: 18, color: SmritiTheme.secondary)),
        ),
      ],
    );
  }
}

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'morning';
  } else if (hour < 18) {
    return 'afternoon';
  } else if (hour < 22) {
    return 'evening';
  } else {
    return 'night';
  }
}
