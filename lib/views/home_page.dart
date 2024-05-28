import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smriti/di/locator.dart';
import 'package:smriti/models/smriti_model.dart';
import 'package:smriti/utils/theme.dart';
import 'package:smriti/viewmodels/create_edit_viewmodel.dart';
import 'package:smriti/viewmodels/home_viewmodel.dart';
import 'package:smriti/views/create_edit_page.dart';

class HomePage extends StatefulWidget {
  static const route = "/home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SmritiTheme.dark,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const AppBar(),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Center(
                    child: Text(
                      "aapki\n  smriti",
                      style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 70,
                          color: SmritiTheme.primary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    height: 42,
                    child: const Tags(),
                  ),
                  const Smritis()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  const AppBar({
    super.key,
  });

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    String name = context.select<HomeViewModel, String>((value) => value.name);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 6),
          child: CircleAvatar(
              radius: 18,
              backgroundColor: SmritiTheme.secondary,
              child: ClipOval(
                child: Image.network(
                  context.read<HomeViewModel>().getProfilePhoto() ?? "",
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person),
                ),
              )),
        ),
        RichText(
          text: TextSpan(
            text: "${getGreeting()}, ",
            style: const TextStyle(
              color: SmritiTheme.secondary,
              fontFamily: "Lato",
            ),
            children: [
              TextSpan(
                  text: name.isEmpty ? "User" : name,
                  style: const TextStyle(color: SmritiTheme.primary)),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              createSmriti(context);
            },
            icon: const Icon(
              Icons.add_rounded,
              color: SmritiTheme.primary,
            ))
      ],
    );
  }
}

createSmriti(BuildContext context) async {
  bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => locator<CreateEditViewModel>(),
          child: const CreateEditPage(),
        ),
      ));
  if (!context.mounted) return;
  if (result != null && result == false) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Empty note discarded!'),
    ));
  }
}

class Tags extends StatefulWidget {
  const Tags({
    super.key,
  });

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  @override
  Widget build(BuildContext context) {
    var tags =
        context.select<HomeViewModel, List<String>>((value) => value.tags);
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: tags
          .map(
            (e) => Container(
                margin: const EdgeInsets.only(right: 12),
                child: TagButton(
                  tag: e,
                  onPressed: () {},
                )),
          )
          .toList(),
    );
  }
}

class Smritis extends StatefulWidget {
  const Smritis({
    super.key,
  });

  @override
  State<Smritis> createState() => _SmritisState();
}

class _SmritisState extends State<Smritis> {
  @override
  Widget build(BuildContext context) {
    var smritis =
        context.select<HomeViewModel, List<Smriti>>((value) => value.smritis);
    if (smritis.isEmpty) {
      return Column(
        children: [
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Oops! No Smriti",
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 26,
                      color: SmritiTheme.secondary,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        createSmriti(context);
                      },
                      child: const Text(
                        "Start creating...",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 26,
                          color: SmritiTheme.active,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      );
    }
    return ListView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: smritis.map((e) => SmritiListTile(smriti: e)).toList(),
    );
  }
}

class TagButton extends StatelessWidget {
  const TagButton({
    super.key,
    required this.tag,
    required this.onPressed,
  });

  final String tag;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          side: WidgetStateProperty.all(
              const BorderSide(color: SmritiTheme.primary)),
          backgroundColor: WidgetStateProperty.all(SmritiTheme.dark)),
      onPressed: onPressed,
      child: Text(
        tag,
        style: const TextStyle(
            fontFamily: "Lato", fontSize: 22, color: SmritiTheme.primary),
      ),
    );
  }
}

class SmritiListTile extends StatelessWidget {
  const SmritiListTile({
    super.key,
    required this.smriti,
  });

  final Smriti smriti;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => locator<CreateEditViewModel>(),
              child: CreateEditPage(
                smriti: smriti,
              ),
            ),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Text(
            smriti.title.isEmpty ? smriti.body.trim() : smriti.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: "Lato", fontSize: 28, color: SmritiTheme.primary),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            child: Text(smriti.body.trim(),
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: "Lato",
                    fontSize: 18,
                    color: SmritiTheme.secondary)),
          ),
        ],
      ),
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
