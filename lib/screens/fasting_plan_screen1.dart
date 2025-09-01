import 'package:flutter/material.dart';
import 'package:fasting/screens/confirm_plan_screen.dart';
import 'package:fasting/screens/fasting_plan_screen2.dart';

class FastingPlan1 {
  final String title;
  final String description;

  FastingPlan1({required this.title, required this.description});
}

class FastingPlanPage1 extends StatelessWidget {
  FastingPlanPage1({super.key});

  final List<FastingPlan1> plans = [
    FastingPlan1(
      title: "16 : 8 Intermittent",
      description:
          "Fast for 16 hours, eat during an 8-hour window. Ideal for beginners.",
    ),
    FastingPlan1(
      title: "18 : 6 Intermittent",
      description:
          "Fast for 18 hours, eat during a 6-hour window. Boosts fat burning.",
    ),
    FastingPlan1(
      title: "20:4 (Warrior Diet)",
      description: "Fast for 20 hours, eat one large meal in 4 hours.",
    ),
    FastingPlan1(
      title: "OMAD (One Meal a Day)",
      description: "Fast for 23 hours, eat one full meal.",
    ),
    FastingPlan1(
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              plan.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "View More",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                    ],
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FastingPlanPage2()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7DAF4A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
        ],
      ),
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FastingPlanPage1(),
//     );
//   }
// }
//pending

// class CustomButton extends StatelessWidget {
//   const CustomButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
