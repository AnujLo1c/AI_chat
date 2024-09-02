import 'package:ai_chat/Model/message.dart';
import 'package:ai_chat/SControllers/theme_controller.dart';
import 'package:ai_chat/Screens/home_screen.dart';
import 'package:ai_chat/Utility/secret_items.dart';
import 'package:ai_chat/Utility/themes.dart';
import 'package:ai_chat/Utility/themes.dart';
import 'package:ai_chat/Utility/themes.dart';
import 'package:ai_chat/Utility/themes.dart';
import 'package:ai_chat/local_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  Gemini.init(apiKey: Api_key);
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = LocalDataStorage();
  final database = await dbHelper.database;
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() =>  GetMaterialApp(
        title: 'AI Chat',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,

      themeMode: themeController.themeMode,
        // theme: themeController.currentTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
