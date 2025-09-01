import 'package:fasting/colors.dart';
import 'package:flutter/material.dart';
import 'package:fasting/confirm_plan.dart';

class FastingPlan2Tile {
  final String title;
  final String description;

  FastingPlan2Tile({required this.title, required this.description});
}

class FastingPlanPage2 extends StatefulWidget {
  const FastingPlanPage2({super.key});

  @override
  State<FastingPlanPage2> createState() => _FastingPlanPage2State();
}

class _FastingPlanPage2State extends State<FastingPlanPage2> {
  int? _selectedIndex;

  final List<FastingPlan2Tile> plans = [
    FastingPlan2Tile(
      title: "16 : 8 Intermittent",
      description: "Fast for 16 hours, eat during an 8-hour window.",
    ),
    FastingPlan2Tile(
      title: "18 : 6 Intermittent",
      description: "Fast for 18 hours, eat during a 6-hour window.",
    ),
    FastingPlan2Tile(
      title: "20:4 (Warrior Diet)",
      description: "Fast for 20 hours, eat one large meal in 4 hours.",
    ),
    FastingPlan2Tile(
      title: "OMAD (One Meal a Day)",
      description: "Fast for 23 hours, eat one full meal.",
    ),
    FastingPlan2Tile(
      title: "5 : 2 Intermittent",
      description:
          "Eat normally for 5 days, restrict calories (~500) for 2 days.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select Fasting Plan"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedIndex = index;
                  }),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.green
                          : AppColors.lightGreen,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 120),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plan.title,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.green.shade800,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      plan.description,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.green.shade800,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "View More",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // The popped-out image
                        Positioned(
                          top: -30,
                          left: 10,
                          child: Image.asset(
                            'assets/images/food.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //have to create a custom button yet
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedIndex != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConfirmPlanPage(plan: plans[_selectedIndex!]),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7DAF4A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
