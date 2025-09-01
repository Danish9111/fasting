import 'package:flutter/material.dart';
import 'package:fasting/screens/set_goals.dart';
import 'package:fasting/screens/home_page.dart';
import 'package:fasting/screens/notification.dart';
import 'package:fasting/screens/recipe_list.dart';

void main() {
  runApp(const MyApp());
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
