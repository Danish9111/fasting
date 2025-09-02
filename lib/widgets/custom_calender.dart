import 'package:fasting/utils/colors.dart';
import 'package:fasting/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';

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

  final DateTime _displayedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs (Daily / Weekly / Monthly)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var view in ["Daily", "Weekly", "Monthly"])
                  GestureDetector(
                    onTap: () => setState(() => _selectedView = view),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        view,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 15,
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: CalendarDatePicker2(
                  key: ValueKey(_displayedMonth),
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.range,
                    // daySplashColor: AppColors.lightGreen,
                    selectedDayHighlightColor: AppColors.green,

                    currentDate: _displayedMonth,

                    selectedRangeHighlightColor: Colors.transparent,

                    daySplashColor: Colors.transparent,
                    dayBuilder:
                        ({
                          required DateTime date,
                          BoxDecoration? decoration, // ignore this
                          bool? isDisabled,
                          bool? isSelected,
                          bool? isToday,
                          TextStyle? textStyle,
                        }) {
                          DateTime d(DateTime x) => DateUtils.dateOnly(x);

                          final dates =
                              _selectedDates
                                  .whereType<DateTime>()
                                  .map(d)
                                  .toList()
                                ..sort();
                          final DateTime? start = dates.isNotEmpty
                              ? dates.first
                              : null;
                          final DateTime? end = dates.length > 1
                              ? dates.last
                              : null;
                          final DateTime today = d(date);

                          final bool isStart =
                              start != null &&
                              DateUtils.isSameDay(today, start);
                          final bool isEnd =
                              end != null && DateUtils.isSameDay(today, end);
                          final bool single =
                              isStart &&
                              (end == null || DateUtils.isSameDay(start, end));
                          final bool inMiddle =
                              start != null &&
                              end != null &&
                              today.isAfter(start) &&
                              today.isBefore(end);

                          return SizedBox(
                            width: 36,
                            height: 36,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Custom stripe (with rounded ends)
                                if (inMiddle || isStart || isEnd)
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.green.withOpacity(0.3),
                                        borderRadius: BorderRadius.horizontal(
                                          left: isStart
                                              ? const Radius.circular(20)
                                              : Radius.zero,
                                          right: isEnd
                                              ? const Radius.circular(20)
                                              : Radius.zero,
                                        ),
                                      ),
                                    ),
                                  ),

                                // Start/end circle
                                if (isStart || isEnd || single)
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: AppColors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),

                                // Day text
                                Text(
                                  '${today.day}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: (isStart || isEnd || single)
                                        ? Colors.white
                                        : (isDisabled == true
                                              ? Colors.grey
                                              : Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                  ),

                  value: _selectedDates,
                  onValueChanged: (dates) =>
                      setState(() => _selectedDates = dates),
                ),
              ),
            ),
          ],
        ),

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
