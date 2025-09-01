// import 'package:flutter/material.dart';
// import 'package:fasting/colors.dart';

// class MealPlanScreen extends StatelessWidget {
//   const MealPlanScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {},
//         ),
//         title: const Text(
//           'Meal Plan',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Meal Plan Overview',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.w900,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               'Your Daily Guide to Staying on Track',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//             const SizedBox(height: 20),

//             // Meal Type Tabs
//             Row(
//               children: [
//                 _buildMealTypeTab('Breakfast', true),
//                 const SizedBox(width: 10),
//                 _buildMealTypeTab('Lunch', false),
//                 const SizedBox(width: 10),
//                 _buildMealTypeTab('Dinner', false),
//               ],
//             ),
//             const SizedBox(height: 25),

//             // Today's Meals Section
//             Container(
//               padding: const EdgeInsets.all(18.0),
//               decoration: BoxDecoration(
//                 color: AppColors.simpleLightGreen, // Light green
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: AppColors.green, // Slightly darker green border
//                   width: 1,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Today\'s Meals',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   _buildMealItem(
//                     'Avocado Toast',
//                     '8:00 AM',
//                     '320 kcal',
//                     Icons.egg,
//                   ),
//                   _buildMealItem(
//                     'Green Salad',
//                     '8:00 AM',
//                     '320 kcal',
//                     Icons.lunch_dining,
//                   ),
//                   _buildMealItem(
//                     'Green Tea',
//                     '8:00 AM',
//                     '320 kcal',
//                     Icons.local_cafe,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 25),

//             // Weekly Plan Information
//             const Text(
//               'Weekly',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               'Week 1 - 5 : 1 Aug 2025 to 5 Sept 2025',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//             const SizedBox(height: 25),

//             // Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildActionButton(
//                     Icons.add,
//                     'Add Plan',
//                     const Color(0xFF66BB6A),
//                   ),
//                 ),
//                 Container(
//                   height: 40,
//                   width: 1,
//                   color: Colors.white, // Divider color
//                 ),
//                 Expanded(
//                   child: _buildActionButton(
//                     Icons.edit_outlined,
//                     'Edit Plan',
//                     const Color(0xFF66BB6A),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 25),

//             // Next Meal in Section
//             Container(
//               padding: EdgeInsets.all(20.0),
//               decoration: BoxDecoration(
//                 color: AppColors.simpleLightGreen, // Light green
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: AppColors.green, width: 1),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.timer, size: 60, color: Colors.green[700]),
//                   const SizedBox(width: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Next Meal in',
//                         style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                       ),
//                       const Text(
//                         '2h 25min',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         'Eating Window Open At 12PM',
//                         style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMealTypeTab(String text, bool isSelected) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: isSelected ? AppColors.green : AppColors.simpleLightGreen,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: isSelected ? Colors.white : const Color(0xFF388E3C),
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _buildMealItem(
//     String mealName,
//     String mealTime,
//     String calories,
//     IconData icon,
//   ) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.grey[200]!),
//                 ),
//                 child: Icon(icon, color: Colors.green[700]),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       mealName,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       mealTime,
//                       style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                     ),
//                   ],
//                 ),
//               ),
//               Text(
//                 calories,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Divider(
//           color: Colors.grey[300],
//           height: 1,
//           indent: 60, // Align with the text
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(IconData icon, String text, Color color) {
//     return ElevatedButton.icon(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         elevation: 0,
//       ),
//       icon: Icon(icon, color: Colors.white),
//       label: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }
