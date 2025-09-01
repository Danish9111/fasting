import 'package:flutter/material.dart';
import 'package:fasting/utils/colors.dart';
import 'package:flutter/cupertino.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool fasting = true;
  bool mealReminders = true;
  bool waterIntake = true;
  bool educationalTips = true;
  bool caloriesIntake = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text("Settings", style: TextStyle(color: Colors.black)),
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
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notifications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Card with options
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    icon: Image.asset(
                      "assets/icons/notification1.png",
                      width: 20,
                      height: 20,
                    ),
                    label: "Fasting Start/End",
                    value: fasting,
                    onChanged: (val) => setState(() => fasting = val),
                  ),
                  _divider(),
                  _buildSwitchTile(
                    icon: Image.asset(
                      "assets/icons/fork&knif.png",
                      width: 20,
                      height: 20,
                    ),
                    label: "Meal Reminders",
                    value: mealReminders,
                    onChanged: (val) => setState(() => mealReminders = val),
                  ),
                  _divider(),
                  _buildSwitchTile(
                    icon: Image.asset(
                      "assets/icons/waterDrop.png",
                      width: 20,
                      height: 20,
                    ),
                    label: "Water Intake",
                    value: waterIntake,
                    onChanged: (val) => setState(() => waterIntake = val),
                  ),
                  _divider(),
                  _buildSwitchTile(
                    icon: Image.asset(
                      "assets/icons/bulb.png",
                      width: 20,
                      height: 20,
                    ),
                    label: "Educational Tips",
                    value: educationalTips,
                    onChanged: (val) => setState(() => educationalTips = val),
                  ),
                  _divider(),
                  _buildSwitchTile(
                    icon: Image.asset(
                      "assets/icons/fire.png",
                      width: 20,
                      height: 20,
                    ),
                    label: "Calories Intake",
                    value: caloriesIntake,
                    onChanged: (val) => setState(() => caloriesIntake = val),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
    );
  }

  Widget _buildSwitchTile({
    required Widget icon,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),

          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.green, // track color when ON
            // inactiveTrackColor: Colors., // track color when OFF
          ),
        ],
      ),
    );
  }
}
