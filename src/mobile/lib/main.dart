import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CineFacilApp());
}

class CineFacilApp extends StatelessWidget {
  const CineFacilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineFácil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}
