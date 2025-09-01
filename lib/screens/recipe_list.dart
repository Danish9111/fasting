import 'package:flutter/material.dart';
import 'package:fasting/utils/custom_text.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fasting/screens/recipe.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  // Dummy data for the recipes
  final List<Map<String, dynamic>> recipes = const [
    {
      'name': 'Avocado Toast',
      'calories': 250,
      'time': 10,
      'color': Colors.green,
      'image': 'assets/images/image1.png',
    },
    {
      'name': 'Chicken Salad',
      'calories': 485,
      'time': 20,
      'color': Colors.red,
      'image': 'assets/images/image2.png',
    },
    {
      'name': 'Tomato Soup',
      'calories': 585,
      'time': 25,
      'color': Colors.green,
      'image': 'assets/images/image3.png',
    },
    {
      'name': 'Fruit Smoothie',
      'calories': 280,
      'time': 5,
      'color': Colors.green,
      'image': 'assets/images/image4.png',
    },
    {
      'name': 'Vegetable Stir-Fry',
      'calories': 400,
      'time': 20,
      'color': Colors.green,
      'image': 'assets/images/image5.png',
    },
    {
      'name': 'Chickpea Salad',
      'calories': 320,
      'time': 10,
      'color': Colors.green,
      'image': 'assets/images/image6.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: AppText('Recipe List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/settings.png',
              height: 20,
              width: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.18),
                          offset: const Offset(-4, -4),
                          blurRadius: 8,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            'assets/icons/appSearch.png',
                            width: 22,
                            height: 22,
                            fit: BoxFit.contain,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.18),
                          offset: const Offset(-4, -4),
                          blurRadius: 8,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Icon(Icons.filter_list, color: Colors.grey, size: 22),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Filter',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return RecipeCard(
                    name: recipe['name']!,
                    calories: recipe['calories']!,
                    time: recipe['time']!,
                    color: recipe['color']!,
                    imageUrl: recipe['image']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String name;
  final int calories;
  final int time;
  final Color color;
  final String imageUrl;

  const RecipeCard({
    super.key,
    required this.name,
    required this.calories,
    required this.time,
    required this.color,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipeDetailPage(recipeTitle: name, imageUrl: imageUrl),
          ),
        );
      },
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    imageUrl,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(name, weight: FontWeight.bold, size: 18),
                    const SizedBox(height: 4),
                    AppText('$calories kcal', size: 14),
                    const SizedBox(height: 4),
                    AppText('$time mins', size: 14),
                  ],
                ),
              ),
              Container(
                width: 30,
                height: 110,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
