import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smriti/di/locator.dart';
import 'package:smriti/viewmodels/home_viewmodel.dart';
import 'package:smriti/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Status bar color
  ));
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
      home: ChangeNotifierProvider(
                          create: (context) => locator<HomeViewModel>(),
                          child: HomePage(),
                        ),
    );
  }
}
