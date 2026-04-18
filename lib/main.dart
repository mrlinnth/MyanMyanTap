import 'package:flutter/material.dart';
import 'screens/start_screen.dart';

void main() {
  runApp(const MyanMyanTapApp());
}

class MyanMyanTapApp extends StatelessWidget {
  const MyanMyanTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Myan Myan Tap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F0EB),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD94F2B)),
      ),
      home: const StartScreen(),
    );
  }
}
