import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smriti/di/locator.dart';
import 'package:smriti/repository/auth_repository.dart';
import 'package:smriti/viewmodels/home_viewmodel.dart';
import 'package:smriti/viewmodels/login_viewmodel.dart';
import 'package:smriti/views/home_page.dart';
import 'package:smriti/views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Status bar color
  ));
  await Firebase.initializeApp();
  await setupLocator();
  runApp(const SmritiApp());
}

class SmritiApp extends StatelessWidget {
  const SmritiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smriti',
      home: locator<AuthRepository>().getAuthStatus() == null
          ? ChangeNotifierProvider(
              create: (context) => locator<LoginViewModel>(),
              child: LoginPage(),
            )
          : ChangeNotifierProvider(
              create: (context) => locator<HomeViewModel>(),
              child: HomePage(),
            ),
    );
  }
}
