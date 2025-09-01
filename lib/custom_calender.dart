import 'package:fasting/colors.dart';
import 'package:fasting/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

// class CustomDateRangePicker {
//   static Future<List<DateTime?>?> show(BuildContext context) {
//     return showDialog<List<DateTime?>>(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Material(
//               borderRadius: BorderRadius.circular(12),
//               child: SizedBox(width: 500, child: _DateRangePickerContent()),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
class CustomDateRangePicker {
  static Future<List<DateTime?>?> show(BuildContext context) {
    return showDialog<List<DateTime?>>(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20), // space outside dialog
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20), // 👈 space inside dialog
                  child: _DateRangePickerContent(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DateRangePickerContent extends StatefulWidget {
  @override
  State<_DateRangePickerContent> createState() =>
      _DateRangePickerContentState();
}

class _DateRangePickerContentState extends State<_DateRangePickerContent> {
  List<DateTime?> _selectedDates = [
    DateTime.now().subtract(const Duration(days: 5)),
    DateTime.now(),
  ];

  String _selectedView = "Daily"; // Daily, Weekly, Monthly

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tabs (Daily / Weekly / Monthly)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var view in ["Daily", "Weekly", "Monthly"])
              GestureDetector(
                onTap: () => setState(() => _selectedView = view),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    view,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _selectedView == view
                          ? Colors.green
                          : Colors.grey[600],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),

        // Calendar
        CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.range,
            daySplashColor: AppColors.green,

            selectedDayHighlightColor: AppColors.green,
            // dayTextStyle: const TextStyle(fontSize: 12),
          ),
          value: _selectedDates,
          onValueChanged: (dates) => setState(() => _selectedDates = dates),
        ),

        // const SizedBox(height: 8),

        // Reset Button
        const SizedBox(height: 12),

        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  setState(() => _selectedDates = []);
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(color: AppColors.green),
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const AppText('Cancel', color: Colors.grey),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, _selectedDates),
                  child: const AppText('Apply', color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
