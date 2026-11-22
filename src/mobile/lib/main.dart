import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'providers/ticket_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TicketProvider(),
      child: const CineFacilApp(),
    ),
  );
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
      home: const MainScreen(),
    );
  }
}