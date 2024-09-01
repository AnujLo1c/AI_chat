import 'package:ai_chat/SControllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        actions: [
          Obx(
                () => IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
              ),
              onPressed: () {
                themeController.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8.0),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: themeController.isDarkMode.value,
              onChanged: (bool value) {
                themeController.toggleTheme();
              },
              activeColor: Colors.white,
            ),
            SizedBox(height: 16.0),
            Text(
              'Additional Settings',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 8.0),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Handle navigation to About page
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                // Handle navigation to Feedback page
              },
            ),
            // Add more settings items here
          ],
        ),
      ),
    );
  }
}
