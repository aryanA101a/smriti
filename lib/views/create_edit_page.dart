import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/utils/theme.dart';
import 'package:smriti/viewmodels/create_edit_viewmodel.dart';

class CreateEditPage extends StatefulWidget {
  static const route = "/CreateEdit";

  final Smriti? smriti;
  const CreateEditPage({super.key, this.smriti});

  @override
  State<CreateEditPage> createState() => _CreateEditPageState();
}

class _CreateEditPageState extends State<CreateEditPage> {
  FocusNode tagFocus = FocusNode();
  FocusNode titleFocus = FocusNode();
  FocusNode bodyFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.smriti != null) {
      context.read<CreateEditViewModel>().loadSmriti(widget.smriti!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tagFocus.dispose();
    titleFocus.dispose();
    bodyFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var date = context.read<CreateEditViewModel>().date;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        onPop(widget.smriti, context);
      },
      child: Scaffold(
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
                      onPop(widget.smriti, context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: SmritiTheme.dark,
                    ),
                  ),
                  if (widget.smriti != null)
                    TextButton(
                        onPressed: () {
                          context
                              .read<CreateEditViewModel>()
                              .deleteSmriti(widget.smriti!);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "delete",
                          style:
                              TextStyle(color: SmritiTheme.dark, fontSize: 16),
                        ))
                ],
              ),
              const Divider(
                color: SmritiTheme.dark,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                          color: SmritiTheme.secondary, fontSize: 16),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller:
                            context.read<CreateEditViewModel>().tagController,
                        focusNode: tagFocus,
                        onSubmitted: (value) =>
                            FocusScope.of(context).requestFocus(titleFocus),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: SmritiTheme.secondary, fontSize: 16),
                        decoration: const InputDecoration(
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
                margin: const EdgeInsets.only(bottom: 0),
                child: TextField(
                  controller:
                      context.read<CreateEditViewModel>().titleController,
                  focusNode: titleFocus,
                  onSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(bodyFocus),
                  maxLines: 1,
                  style: const TextStyle(
                      fontFamily: "Lato",
                      color: SmritiTheme.dark,
                      fontSize: 36),
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                child: TextField(
                  controller:
                      context.read<CreateEditViewModel>().bodyController,
                  focusNode: bodyFocus,
                  onTapOutside: (event) =>
                      FocusScope.of(context).requestFocus(bodyFocus),
                  style: const TextStyle(
                      fontFamily: "Lato", color: SmritiTheme.secondary),
                  decoration: const InputDecoration(
                    hintText: "Write here...",
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void onPop(Smriti? smriti, BuildContext context) {
  if (smriti != null) {
    context.read<CreateEditViewModel>().updateSmriti(smriti);
    Navigator.pop(context);
  } else {
    bool result = context.read<CreateEditViewModel>().saveSmriti();
    Navigator.pop(context, result);
  }
}
