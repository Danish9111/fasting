import 'package:flutter/material.dart';
import 'package:fasting/colors.dart';
import 'package:fasting/custom_text.dart';

class MealTypeSelector extends StatefulWidget {
  const MealTypeSelector({super.key});

  @override
  State<MealTypeSelector> createState() => _MealTypeSelectorState();
}

class _MealTypeSelectorState extends State<MealTypeSelector> {
  int _selectedIndex = 0;
  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Dinner'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        _mealTypes.length,
        (index) => Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? AppColors.green
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Flexible(
                  child: AppText(
                    _mealTypes[index],

                    color: _selectedIndex == index
                        ? Colors.white
                        : const Color(0xFF8BC34A),
                    weight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
