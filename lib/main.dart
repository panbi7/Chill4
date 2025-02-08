import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:chill4_promotion_community/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme(ThemeData.light().textTheme).light(),
      home: const HomeScreen(),
    );
  }
}