// import 'package:fasting/calender.dart';
import 'package:fasting/colors.dart';
import 'package:flutter/material.dart';
import 'package:fasting/widgets/meal_type_selector.dart';
import 'package:fasting/custom_text.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fasting/custom_calender.dart';

class CustomMealPlanScreen extends StatefulWidget {
  const CustomMealPlanScreen({super.key});

  @override
  State<CustomMealPlanScreen> createState() => _CustomMealPlanScreenState();
}

class _CustomMealPlanScreenState extends State<CustomMealPlanScreen> {
  final List<Map<String, String>> selectedMeals = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int _currentCarouselIndex = 0;

  void _addMeal(String imageUrl, String title, String calories) {
    final exists = selectedMeals.indexWhere((m) => m['title'] == title) != -1;
    if (exists) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Meal already selected')));
      return;
    }
    final item = {'image': imageUrl, 'title': title, 'calories': calories};
    selectedMeals.insert(0, item);
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 300),
    );
    setState(() {});
  }

  void _removeMeal(int index) {
    if (index < 0 || index >= selectedMeals.length) return;
    final removed = selectedMeals.removeAt(index);
    _listKey.currentState?.removeItem(
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
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Meal removed'),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            selectedMeals.insert(index, removed);
            _listKey.currentState?.insertItem(
              index,
              duration: const Duration(milliseconds: 300),
            );
            setState(() {});
          },
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText('Add Custom Plan', size: 30, weight: FontWeight.bold),
                const Spacer(),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () async {
                    final result = await CustomDateRangePicker.show(context);
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
            const SizedBox(height: 16),
            _buildMealOptions(),
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
                  key: _listKey,
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
                          onDelete: () => _removeMeal(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 16),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMealOptions() {
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
        return _buildMealCard(data['title']!, data['cal']!, data['img']!, idx);
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
          setState(() => _currentCarouselIndex = index);
        },
      ),
    );
  }

  Widget _buildMealCard(
    String title,
    String calories,
    String imageUrl,
    int index,
  ) {
    return SingleChildScrollView(
      child: Container(
        width: 170,
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
                    // Animate blur: central image is sharp, others are blurred
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: _currentCarouselIndex == index ? 0.0 : 6.0,
                        end: _currentCarouselIndex == index ? 0.0 : 6.0,
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
                          _addMeal(imageUrl, title, calories);
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
}

class DailySchedule extends StatefulWidget {
  const DailySchedule({super.key});

  @override
  State<DailySchedule> createState() => _DailyScheduleState();
}

class _DailyScheduleState extends State<DailySchedule> {
  final days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  final Set<int> selectedDays = {}; // track selected indices

  @override
  Widget build(BuildContext context) {
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
                      setState(() {
                        if (isSelected) {
                          selectedDays.remove(index);
                        } else {
                          selectedDays.add(index);
                        }
                      });
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
      color: AppColors.green, // background here
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30), // match rounded shape
        splashColor: Colors.white.withOpacity(.3), // visible now
        onTap: () {}, // required for splash to trigger
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
