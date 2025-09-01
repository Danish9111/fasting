import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fasting/colors.dart';
import 'package:fasting/custom_text.dart';

class MealTimer extends StatelessWidget {
  const MealTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.simpleLightGreen,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Center(child: Image.asset('assets/icons/timer.png')),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Next Meal in',
                    size: 16,
                    color: Colors.black87,
                    weight: FontWeight.bold,
                  ),
                  AppText(
                    '2h 25min',
                    size: 28,
                    weight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  AppText(
                    'Eating Window Open At 12PM',
                    size: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
