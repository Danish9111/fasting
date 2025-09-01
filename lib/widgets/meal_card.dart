import 'package:flutter/material.dart';
import 'package:fasting/colors.dart';
import 'package:fasting/custom_text.dart';

class MealCard extends StatelessWidget {
  final String icon;
  final String mealName;
  final String time;
  final String calories;

  const MealCard({
    super.key,
    required this.icon,
    required this.mealName,
    required this.time,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      height: 65,
      child: Row(
        children: [
          Center(
            child: Image.asset(
              icon,
              width: 48,
              height: 48,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  getIconForMeal(mealName),
                  color: Colors.grey,
                  size: 24,
                );
              },
            ),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  mealName,

                  size: 16,
                  weight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
                AppText(time, size: 14, color: Color(0xFF666666)),
              ],
            ),
          ),
          AppText(
            calories,

            size: 14,
            // weight: FontWeight.bold,
            color: Colors.grey,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  IconData getIconForMeal(String meal) {
    if (meal.toLowerCase().contains('toast')) {
      return Icons.breakfast_dining;
    } else if (meal.toLowerCase().contains('salad')) {
      return Icons.restaurant;
    } else if (meal.toLowerCase().contains('tea')) {
      return Icons.coffee;
    }
    return Icons.food_bank;
  }
}
