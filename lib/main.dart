import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting/screens/home_screen.dart';
import 'package:fasting/screens/notification_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Goals App',

      routes: {
        // '/': (context) => RecipeListPage(), // default start
        '/': (context) => HomePage(), // default start
        // '/setGoals': (context) => const SetGoalsPage(),
        '/notification': (context) => const NotificationSettingsPage(),
        // '/homePage':(context) => const HomePage(),
      },

      initialRoute: '/',
    );
  }
}
