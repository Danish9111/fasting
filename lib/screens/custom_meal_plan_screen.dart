import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting/providers/meal_plan_providers.dart';
import 'package:fasting/utils/colors.dart';
import 'package:fasting/widgets/meal_type_selector.dart';
import 'package:fasting/utils/custom_text.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fasting/widgets/custom_calender.dart';

class CustomMealPlanScreen extends ConsumerWidget {
  const CustomMealPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMeals = ref.watch(selectedMealsProvider);
    final carouselIndex = ref.watch(carouselIndexProvider);
    final listKey = ref.watch(listKeyProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Custom Meal Plan'),
        actions: [
          Image.asset('assets/icons/settings.png', height: 20),
          const SizedBox(width: 20),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
              bottom: 120,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      'Add Custom Plan',
                      size: 30,
                      weight: FontWeight.bold,
                    ),
                    const Spacer(),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: () async {
                        final result = await CustomDateRangePicker.show(
                          context,
                        );
                        if (result != null && result.isNotEmpty) {
                          debugPrint("Selected range: $result");
                        }
                      },
                      icon: Image.asset(
                        'assets/icons/calenderEdit.png',
                        height: 20,
                      ),
                    ),
                  ],
                ),
                const AppText(
                  'Build Your ideal weekly meal routine',
                  color: Colors.black87,
                ),
                const SizedBox(height: 10),
                MealTypeSelector(),
                const SizedBox(height: 10),
                // const SizedBox(height: 16),
                _buildMealOptions(ref, carouselIndex),
                const SizedBox(height: 10),
                DailySchedule(),
                const SizedBox(height: 10),
                if (selectedMeals.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const AppText('Selected Meals', weight: FontWeight.bold),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 220,
                    child: AnimatedList(
                      key: listKey,
                      initialItemCount: selectedMeals.length,
                      padding: const EdgeInsets.only(top: 8),
                      itemBuilder: (context, index, animation) {
                        final meal = selectedMeals[index];
                        return SizeTransition(
                          sizeFactor: animation,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildSelectedMealItem(
                              meal['image'],
                              meal['title'],
                              meal['calories'],
                              onDelete: () => _removeMeal(ref, index),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _buildSaveButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildMealOptions(WidgetRef ref, int carouselIndex) {
    final items = [
      {
        'title': 'Avocado Toast',
        'cal': '320 kcal',
        'img': 'assets/images/image1.png',
      },
      {
        'title': 'Oatmeal',
        'cal': '420 kcal',
        'img': 'assets/images/image2.png',
      },
      {
        'title': 'Fruit Smoothie',
        'cal': '300 kcal',
        'img': 'assets/images/image4.png',
      },
      {
        'title': 'Tomato Soup',
        'cal': '80 kcal',
        'img': 'assets/images/image3.png',
      },
    ];

    return CarouselSlider(
      items: items.asMap().entries.map((e) {
        final idx = e.key;
        final data = e.value;
        return _buildMealCard(
          data['title']!,
          data['cal']!,
          data['img']!,
          idx,
          ref,
        );
      }).toList(),
      options: CarouselOptions(
        height: 230,
        enlargeCenterPage: true,
        viewportFraction: .5,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        initialPage: 0,
        onPageChanged: (index, reason) {
          ref.read(carouselIndexProvider.notifier).state = index;
        },
      ),
    );
  }

  Widget _buildMealCard(
    String title,
    String calories,
    String imageUrl,
    int index,
    WidgetRef ref,
  ) {
    return SingleChildScrollView(
      child: Container(
        width: 170,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Stack(
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: ref.watch(carouselIndexProvider) == index
                            ? 0.0
                            : 6.0,
                        end: ref.watch(carouselIndexProvider) == index
                            ? 0.0
                            : 6.0,
                      ),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, sigma, child) {
                        return ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: sigma,
                            sigmaY: sigma,
                          ),
                          child: child,
                        );
                      },
                      child: Image.asset(
                        imageUrl,
                        height: 106,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title, weight: FontWeight.bold),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(calories, color: Colors.black87),
                      InkWell(
                        onTap: () {
                          _addMeal(ref, imageUrl, title, calories);
                        },
                        customBorder: const CircleBorder(),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addMeal(WidgetRef ref, String imageUrl, String title, String calories) {
    final selectedMeals = ref.watch(selectedMealsProvider);
    final exists = selectedMeals.any((m) => m['title'] == title);
    if (exists) {
      ScaffoldMessenger.of(
        ref.context,
      ).showSnackBar(SnackBar(content: Text('Meal already selected')));
      return;
    }
    final notifier = ref.read(selectedMealsProvider.notifier);
    notifier.addMeal(imageUrl, title, calories);
    ref
        .read(listKeyProvider)
        .currentState
        ?.insertItem(0, duration: const Duration(milliseconds: 300));
  }

  void _removeMeal(WidgetRef ref, int index) {
    final notifier = ref.read(selectedMealsProvider.notifier);
    final listKey = ref.read(listKeyProvider);
    final removed = notifier.removeMeal(index);
    if (removed != null) {
      listKey.currentState?.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildSelectedMealItem(
              removed['image'],
              removed['title'],
              removed['calories'],
              onDelete: () {},
            ),
          ),
        ),
        duration: const Duration(milliseconds: 250),
      );
      ref.read(lastRemovedProvider.notifier).state = removed;
      ref.read(lastRemovedIndexProvider.notifier).state = index;
      ScaffoldMessenger.of(ref.context).clearSnackBars();
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(
          content: const Text('Meal removed'),
          action: SnackBarAction(
            label: 'UNDO',
            textColor: Colors.white,
            onPressed: () {
              final lastRemoved = ref.read(lastRemovedProvider);
              final lastIndex = ref.read(lastRemovedIndexProvider);
              if (lastRemoved != null && lastIndex != null) {
                notifier.undoRemove(lastIndex, lastRemoved);
                listKey.currentState?.insertItem(
                  lastIndex,
                  duration: const Duration(milliseconds: 300),
                );
                ref.read(lastRemovedProvider.notifier).state = null;
                ref.read(lastRemovedIndexProvider.notifier).state = null;
              }
            },
          ),
        ),
      );
    }
  }
}

class DailySchedule extends ConsumerWidget {
  const DailySchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDays = ref.watch(selectedDaysProvider);
    final days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText('Daily', weight: FontWeight.bold, size: 18),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            itemBuilder: (context, index) {
              final isSelected = selectedDays.contains(index);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Material(
                  color: isSelected ? AppColors.green : Colors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    splashColor: AppColors.green.withOpacity(.3),
                    onTap: () {
                      ref.read(selectedDaysProvider.notifier).toggleDay(index);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: Center(
                        child: AppText(
                          days[index],
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildSelectedMealItem(
  imageUrl,
  title,
  calories, {
  VoidCallback? onDelete,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.green),
      color: AppColors.simpleLightGreen,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imageUrl,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title, weight: FontWeight.bold),
              AppText(calories, color: Colors.black87),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 173, 216, 129), AppColors.green],
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSaveButton() {
  return Center(
    child: Material(
      color: AppColors.green,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.white.withOpacity(.3),
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: const AppText(
            'Save Custom Plan',
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
