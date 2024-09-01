import 'dart:io';

import 'package:ai_chat/SControllers/home_screen_controller.dart';
import 'package:ai_chat/Utility/chatmsgbox.dart';
import 'package:ai_chat/Utility/colors.dart';
import 'package:ai_chat/Widgets/chat_create_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    HomeScreenController homeScreenController = Get.put(HomeScreenController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: MyColors.primary,
        backgroundColor: MyColors.secondary,
        title: const Text(
          "AI Chat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: MyColors.secondary, size: 25),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              homeScreenController.clearChat();
            },
            icon: const Icon(Icons.cleaning_services_rounded, color: MyColors.secondary, size: 25),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ChatCreateDialog(
                  controller: homeScreenController.dialog,
                  homeScreenController: homeScreenController, // Use the existing controller
                ),
              );
            },
            icon: const Icon(Icons.add_box, color: MyColors.secondary, size: 30),
          )
        ],
      ),
      backgroundColor: MyColors.primary,
      drawer: Drawer(
        backgroundColor: MyColors.sidepanel,
        width: 200,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              width: 200,
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: MyColors.primary,
                ),
                child: Text(
                  'Chats',
                  style: TextStyle(
                    color: MyColors.secondary2,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Obx(
                    () => ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  itemCount: homeScreenController.chatHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(left: 8),
                      minVerticalPadding: 0,
                      onTap: () {

                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.black),
                      ),
                      tileColor: MyColors.sidepaneltile,
                      trailing:  IconButton(icon: Icon(Icons.delete), onPressed: () {
                          String tableName = homeScreenController.chatHistory[index];
                          if (tableName == "tempChat") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Can't delete default chat")),
                            );
                          } else {
                            homeScreenController.deleteChat(tableName);
                          }
                      },
                      ),
                      title: Text(homeScreenController.chatHistory[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Gap(5),
                ),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: Colors.black,
            ),
            Container(
              height: 120,
              color: Colors.grey, // Adjust the height as needed
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings, color: MyColors.primary),
                    title: const Text('Settings', style: TextStyle(color: MyColors.primary)),
                    onTap: () {
                      // Handle settings navigation
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app_sharp, color: MyColors.primary),
                    title: const Text('Exit', style: TextStyle(color: MyColors.primary)),
                    onTap: () {
                      exit(0);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                reverse: true,
                itemCount: homeScreenController.chatmsgs.length,
                itemBuilder: (context, index) => ChatmsgBox(
                  text: homeScreenController.chatmsgs[index].chatmsg,
                  ai: homeScreenController.chatmsgs[index].ai,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: MyColors.secondary,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: homeScreenController.chat,
                    decoration: const InputDecoration(
                      hintText: 'Type your message',
                      hintStyle: TextStyle(color: MyColors.secondary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.primary, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.primary, width: 2),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    homeScreenController.addInChatMsgs();
                    homeScreenController.hitApi();
                    homeScreenController.chat.clear();
                  },
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: MyColors.secondary,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
