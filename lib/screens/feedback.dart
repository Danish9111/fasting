import 'package:fasting/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fasting/utils/custom_text.dart';
import 'package:fasting/widgets/multi_color_slider.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  int rating = 0;
  double sliderValue = 0.3;
  bool isAnonymous = false;
  bool isBoxChecked = false;

  Color color1 = const Color(0xFFCC2334);
  Color color2 = const Color(0xFFEF4B3F);
  Color color3 = const Color(0xFFEF8035);
  Color color4 = const Color(0xFFEFB025);
  Color color5 = const Color(0xFF6EBF43);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(15),

      content: SingleChildScrollView(
        // so it won’t overflow
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const AppText("Feedback Us", size: 30, weight: FontWeight.bold),
            const SizedBox(height: 8),
            const AppText("How Did You Feel About Recipe", size: 10),
            SizedBox(height: 10),

            // Star Rating
            Row(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                  behavior: HitTestBehavior.opaque,

                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        decoration: BoxDecoration(
                          // shape: ,
                          color: index < rating
                              ? AppColors.green
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // color: AppColors.green,
                        child: IconButton(
                          icon: Icon(Icons.star, size: 32, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              rating = index + 1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 8),
            const AppText("Write Your Experiences", size: 14),

            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Type Here..",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),

            const SizedBox(height: 16),
            const AppText("Taste", size: 14),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/angry.png', height: 40, width: 40),
                Image.asset('assets/icons/sad.png', height: 40, width: 40),
                Image.asset('assets/icons/neutral.png', height: 40, width: 40),
                Image.asset('assets/icons/good.png', height: 40, width: 40),
                Image.asset('assets/icons/happy.png', height: 40, width: 40),
              ],
            ),

            const SizedBox(height: 8),
            MultiColorSlider(
              colors: [color1, color2, color3, color4, color5],
              value: sliderValue,
              onChanged: (v) => setState(() => sliderValue = v),
            ),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isAnonymous = !isAnonymous;
                      isBoxChecked = !isBoxChecked;
                    });
                  },
                  icon: Icon(
                    Icons.check_box,
                    color: isBoxChecked
                        ? AppColors.green
                        : Colors.grey.shade300,
                  ),
                ),
                const AppText("Submit Anonymous Feedback", size: 12),
              ],
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onPressed: () {
              // handle submit
              Navigator.pop(context);
            },
            child: const AppText(
              "Submit Now",
              size: 18,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
