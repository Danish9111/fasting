import 'package:fasting/colors.dart';
import 'package:fasting/notification.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset(
              "assets/icons/settings.png",
              width: 20,
              height: 20,
            ),
            onPressed: () {
              // Handle settings button press
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings & Profile Management Section
            const Text(
              'Settings & Profile Management',
              maxLines: 2,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildProfileCard(context),
            const SizedBox(height: 32),

            // Settings Section
            const Text(
              'Settings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSettingOption(
              icon: Image.asset(
                "assets/icons/language.png",
                width: 20,
                height: 20,
              ),
              title: "Language",
              onTap: () {
                print("Home tapped");
              },
            ),

            _buildSettingOption(
              icon: Image.asset(
                "assets/icons/privacy.png",
                width: 20,
                height: 20,
              ),
              title: 'Privacy & Data Export',
              onTap: () {},
            ),
            _buildSettingOption(
              icon: Image.asset(
                "assets/icons/logout.png",
                width: 20,
                height: 20,
              ),
              title: 'Logout',
              onTap: () {},
            ),
            _buildSettingOption(
              icon: Image.asset(
                "assets/icons/notification.png",
                width: 20,
                height: 20,
              ),
              title: 'Notification',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationSettingsPage(),
                  ),
                );
              },
            ),
            _buildSettingOption(
              icon: Image.asset(
                "assets/icons/policy.png",
                width: 20,
                height: 20,
              ),
              title: 'Privacy Policy',
              onTap: () {},
            ),
            _buildSettingOption(
              icon: Image.asset(
                "assets/icons/terms.png",
                width: 20,
                height: 20,
              ),
              title: 'Terms & Condition',
              onTap: () {},
            ),
            _buildSettingOption(
              icon: Image.asset(
                "assets/icons/delete.png",
                width: 20,
                height: 20,
              ),
              title: 'Account Deletion',
              onTap: () {},
            ),
            _buildSettingOption(
              icon: Image.asset("assets/icons/save.png", width: 24, height: 24),
              title: 'Save Recipes',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/woman.png"),
              ),
              const SizedBox(width: 16),
              const Text(
                'Olivia Wilson',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProfileMetric('Weight', '150 lb'),
                SizedBox(
                  height: 70,
                  child: VerticalDivider(
                    color: Colors.grey[300],
                    thickness: 1,
                    width: 20,
                  ),
                ),

                _buildProfileMetric('Fast', '7 Streak'),
                SizedBox(
                  height: 70,
                  child: VerticalDivider(
                    color: Colors.grey[300],
                    thickness: 1,
                    width: 20,
                  ),
                ),
                _buildProfileMetric('Goal', '140 lb'),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  Text('Edit Profile', style: TextStyle(fontSize: 18)),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),

                    child: IconButton(
                      icon: Image.asset(
                        "assets/icons/edit.png",
                        width: 20,
                        height: 20,
                      ),
                      onPressed: () {
                        // Handle settings button press
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMetric(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          const SizedBox(
            width: 80,
            child: Divider(
              thickness: 5,
              radius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOption({
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
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
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.grey.shade100,
          ),

          child: icon,
        ),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward, color: Colors.black),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
