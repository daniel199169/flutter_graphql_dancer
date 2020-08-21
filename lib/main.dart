import 'package:dancer/screens/private/home_wrapper.dart';
import 'package:dancer/styles/dancer_theme.dart';
import 'package:flutter/material.dart';
import 'package:dancer/screens/public/register_screen.dart';
import 'package:dancer/globals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      theme: DancerTheme.lightTheme,
      home: RegisterScreen(),
    );
  }
}
