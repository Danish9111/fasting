import 'package:fasting/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasting/widgets/meal_card.dart';
import 'package:fasting/widgets/meal_timer.dart';
import 'package:fasting/widgets/meal_type_selector.dart';
import 'package:fasting/utils/custom_text.dart';
import 'package:fasting/screens/custom_meal_plan_screen.dart';

class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,

        title: const AppText(
          'Meal Plan',
          size: 20,
          weight: FontWeight.bold,
          color: Colors.black87,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/settings.png', height: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppText(
                      'Meal Plan Overview',
                      size: 24,
                      weight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    const SizedBox(height: 4),
                    const AppText(
                      'Your Daily Guide to Staying on Track',
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const MealTypeSelector(),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: AppColors.simpleLightGreen,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: AppColors.simpleLightGreen,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            'Today\'s Meals',
                            size: 18,
                            weight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 10),
                          const MealCard(
                            icon: 'assets/images/avocado.png',
                            mealName: 'Avocado Toast',
                            time: '8:00 AM',
                            calories: '220 kcal',
                          ),
                          const SizedBox(height: 12),
                          const MealCard(
                            icon: 'assets/images/salad.png',
                            mealName: 'Green Salad',
                            time: '8:00 AM',
                            calories: '320 kcal',
                          ),
                          const SizedBox(height: 12),
                          const MealCard(
                            icon: 'assets/images/tea.png',
                            mealName: 'Green Tea',
                            time: '8:00 AM',
                            calories: '320 kcal',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText('Weekly', size: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        'Week 1 · 1 Aug 2023 to 5 Sept 2023',
                        size: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buttons(context),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const MealTimer(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buttons(context) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
      color: AppColors.green,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    child: Row(
      children: [
        // Left Button
        Expanded(
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomMealPlanScreen(),
                  ),
                );
              },
              splashColor: Colors.white24,
              child: SizedBox.expand(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, color: Colors.white, size: 18),
                    SizedBox(width: 5),
                    Text('Add Meal', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Divider
        SizedBox(
          width: 1,
          height: 30,
          child: DecoratedBox(decoration: BoxDecoration(color: Colors.white)),
        ),

        // Right Button
        Expanded(
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              splashColor: Colors.white24,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const DashboardPage(),
                //   ),
                // );
              },
              child: SizedBox.expand(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.square_pencil_fill,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text("Edit Meal", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
