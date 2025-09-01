import 'package:fasting/colors.dart';
import 'package:fasting/custom_text.dart';
import 'package:fasting/feedback.dart';
import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String imageUrl;
  final String recipeTitle;
  const RecipeDetailPage({
    super.key,
    required this.imageUrl,
    required this.recipeTitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: AppText(
          'Recipe Details',
          color: Colors.black,
          weight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/settings.png',
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          // Foreground content with rounded corners
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SizedBox(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      AppText(
                        recipeTitle,
                        color: Colors.black,
                        weight: FontWeight.bold,
                        size: 25,
                      ),
                      const SizedBox(height: 10),

                      // Info section
                      const AppText("Calories: ~300 kcal"),
                      const AppText("Prep Time: 10 minutes"),
                      const AppText("Serves: 1"),
                      const SizedBox(height: 20),

                      // Ingredients
                      const AppText(
                        "Ingredients:",
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      const AppText(
                        "• 1 slice whole grain or multigrain bread - 80 kcal",
                      ),
                      const AppText("• ½ ripe avocado - 120 kcal"),
                      const AppText("• 1 tsp lemon juice - 0 kcal"),
                      const AppText("• Salt & pepper to taste - ~0 kcal"),
                      const SizedBox(height: 20),

                      // Instructions
                      const AppText(
                        "Instructions:",
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      const AppText(
                        "Toast the bread to your desired crispness. "
                        "Mash the avocado in a bowl with lemon juice, salt, and pepper.\n\n"
                        "Spread the avocado mixture evenly on the toasted bread. "
                        "Top it with your optional add-ons like a poached egg or tomatoes. "
                        "Serve immediately while warm and fresh.",
                        color: Colors.black,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Buttons section (fixed at bottom, outside scrollable area)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        overlayColor: Colors.green,
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {},
                      child: const AppText("Save Recipe", color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,

                          builder: (context) {
                            return FeedbackDialog();
                          },
                        );
                      },
                      child: AppText('Review Recipe', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
