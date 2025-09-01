import 'package:flutter/material.dart';
import 'set_goals_screen.dart';
import 'package:fasting/utils/colors.dart';
import 'package:fasting/screens/settings_screen.dart';
import 'package:fasting/screens/meal_screen.dart';
import 'package:fasting/screens/meal_plan_screen.dart';
import 'package:fasting/screens/article_detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const GoalsPage(),
    const ArticleDetailPage(),
    const MealPlanScreen(),
    const SettingsPage(),
    const ProfilePage(),
  ];
  void onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }
}

class CustomNavigationBar extends StatefulWidget {
  int currentIndex = 0;
  Function onTabSelected;
  CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  // int _currentIndex = 0;

  final List<Map<String, String>> _navItems = [
    {
      "icon": "assets/icons/home.png",
      "activeIcon": "assets/icons/home_selected.png",
      "label": "Home",
    },
    {
      "icon": "assets/icons/article.png",
      "activeIcon": "assets/icons/article_selected.png",
      "label": "Article",
    },
    {
      "icon": "assets/icons/mealplan.png",
      "activeIcon": "assets/icons/mealplan_selected.png",
      "label": "Meal Plan",
    },
    {
      "icon": "assets/icons/setting.png",
      "activeIcon": "assets/icons/setting_selected.png",
      "label": "Settings",
    },
    {
      "icon": "assets/icons/profile.png",
      "activeIcon": "assets/icons/profile.png",
      "label": "Profile",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      clipBehavior: Clip.hardEdge,
      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (index) {
          final item = _navItems[index];
          final isSelected = widget.currentIndex == index;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onTabSelected(index),
              splashColor: AppColors.green.withOpacity(.2),
              highlightColor: Colors.transparent,
              child: SizedBox(
                width: 70,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      isSelected ? item["activeIcon"]! : item["icon"]!,
                      width: 25,
                      height: 25,
                      color: isSelected ? AppColors.green : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["label"]!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? AppColors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: const Center(child: Text("Profile Page")),
    );
  }
}
