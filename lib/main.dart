import 'package:ai_chat/Model/message.dart';
import 'package:ai_chat/Screens/home_screen.dart';
import 'package:ai_chat/Utility/secret_items.dart';
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
  // print();
  // Message newMsg=Message(chatmsg: "hiiel", ai: false,id: 1,time: DateTime.timestamp());
  // await dbHelper.insertMsg(newMsg);
  // List<Message> tasks = await dbHelper.getTasks();
  // for (Message task in tasks) {
  //   print('Task: ${task.chatmsg}, Completed: ${task.ai}, ${task.time}, ${task.id}');
  // }
  //
  // Message taskToUpdate = tasks[0];
  // taskToUpdate.ai = true;
  // await dbHelper.updateTask(taskToUpdate);
  // tasks = await dbHelper.getTasks();
  // for (Message task in tasks) {
  //   print('Task: ${task.chatmsg}, Completed: ${task.ai}, ${task.time}, ${task.id}');
  // }
  // await dbHelper.deleteTask(taskToUpdate.id!);
  // tasks = await dbHelper.getTasks();
  // for (Message task in tasks) {
  //   print('Task: ${task.chatmsg}, Completed: ${task.ai}, ${task.time}, ${task.id}');
  // }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AI Chat',
debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
