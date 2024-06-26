import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smriti/di/locator.dart';
import 'package:smriti/utils/theme.dart';
import 'package:smriti/viewmodels/login_viewmodel.dart';
import 'package:smriti/viewmodels/home_viewmodel.dart';
import 'package:smriti/views/home_page.dart';

class LoginPage extends StatelessWidget {
  static const route = "/login";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SmritiTheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "smriti",
              style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 70,
                  color: SmritiTheme.active,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: AuthButton(
                onPressed: () async {
                  var credentials =
                      await context.read<LoginViewModel>().googleSignIn();
                  if (!context.mounted) return;
                  if (credentials != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => locator<HomeViewModel>(),
                          child: const HomePage(),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Something went wrong!'),
                    ));
                  }
                },
                icon: FontAwesomeIcons.google,
                text: "Connect with Google",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  final void Function()? onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16)),
          side: WidgetStateProperty.all(
              const BorderSide(color: SmritiTheme.dark)),
          backgroundColor: WidgetStateProperty.all(SmritiTheme.primary)),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: SmritiTheme.dark,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: const TextStyle(
                  fontFamily: "Lato", fontSize: 26, color: SmritiTheme.dark),
            ),
          ),
        ],
      ),
    );
  }
}
