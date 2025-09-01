import 'package:flutter/material.dart';
import 'package:fasting/utils/colors.dart';
import 'package:fasting/screens/fasting_plan1.dart';

class Goal {
  final String title;
  final String asset; // image/icon path
  Goal(this.title, this.asset);
}

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final List<Goal> goals = [
    Goal("Lose weight", "assets/images/lose_weight.png"),
    Goal("Boost Metabolism", "assets/images/body.png"),
    Goal("Mental Clarity", "assets/images/brain.png"),
    Goal("Detox", "assets/images/detox.png"),
    Goal("Build Discipline", "assets/images/discipline.png"),
    Goal("Better Sleep", "assets/images/sleep.png"),
    Goal("Regulate Blood Sugar", "assets/images/blood.png"),
    Goal("Enhance Longevity", "assets/images/heart.png"),
  ];

  // track selected ones
  final Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Set Goals"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: goals.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 per row
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, i) {
                final isSelected = selectedIndexes.contains(i);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedIndexes.remove(i);
                      } else {
                        selectedIndexes.add(i);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFE1FFC2) : Colors.white,
                      borderRadius: BorderRadius.circular(16),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Image.asset(
                              goals[i].asset,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          goals[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FastingPlanPage1()),
                  );

                  debugPrint("Selected goals: $selectedIndexes");
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
