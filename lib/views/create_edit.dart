import 'package:flutter/material.dart';
import 'package:smriti/utils/theme.dart';

class CreateEdit extends StatelessWidget {
  CreateEdit({super.key});
  FocusNode tagFocus = FocusNode();
  FocusNode titleFocus = FocusNode();
  FocusNode bodyFocus = FocusNode();

  TextEditingController tagController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SmritiTheme.primary,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: SmritiTheme.dark,
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "delete",
                      style: TextStyle(color: SmritiTheme.dark, fontSize: 16),
                    ))
              ],
            ),
            Divider(
              color: SmritiTheme.dark,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "18 / 11 / 22",
                    style:
                        TextStyle(color: SmritiTheme.secondary, fontSize: 16),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: tagController,
                      focusNode: tagFocus,
                      onSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(titleFocus),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(color: SmritiTheme.secondary, fontSize: 16),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "#tag",
                          hintStyle: TextStyle(
                              color: SmritiTheme.secondary, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 0),
              child: TextField(
                controller: titleController,
                focusNode: titleFocus,
                onSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(bodyFocus),
                maxLines: 1,
                style: TextStyle(color: SmritiTheme.dark, fontSize: 36),
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              child: TextField(
                controller: bodyController,
                focusNode: bodyFocus,
                onTapOutside: (event) =>
                    FocusScope.of(context).requestFocus(bodyFocus),
                style: TextStyle(color: SmritiTheme.secondary),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
