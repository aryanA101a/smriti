import 'package:flutter/material.dart';
import 'package:smriti/views/login.dart';
import 'package:smriti/views/smriti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Smriti',
      home: Login(),
    );
  }
}
