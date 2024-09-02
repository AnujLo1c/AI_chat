import 'dart:io';

import 'package:ai_chat/SControllers/home_screen_controller.dart';
import 'package:ai_chat/SControllers/theme_controller.dart';
import 'package:ai_chat/Screens/settings.dart';
import 'package:ai_chat/Utility/chatmsgbox.dart';
import 'package:ai_chat/Utility/colors.dart';
import 'package:ai_chat/Widgets/chat_create_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    HomeScreenController homeScreenController = Get.put(HomeScreenController());
ThemeController themeController=Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Get.theme.primaryColor,
        backgroundColor: Get.theme.primaryColorDark,
        title: const Text(
          "AI Chat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon:  Icon(Icons.menu, color: Get.theme.primaryColor, size: 25),
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
            icon:  Icon(Icons.cleaning_services_rounded, color: Get.theme.primaryColor, size: 25),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ChatCreateDialog(
                  controller: homeScreenController.dialog,
                  homeScreenController: homeScreenController,
                ),
              );
            },
            icon:  Icon(Icons.add_box, color: Get.theme.primaryColor, size: 30),
          )
        ],
      ),
      backgroundColor: Get.theme.primaryColor,
      drawer: Drawer(
        backgroundColor: Get.theme.dividerColor.withOpacity(.8),
        width: 200,
        child: Column(
          children: [
            SizedBox(
              height: 110,
              width: 200,
              child: DrawerHeader(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Get.theme.hoverColor,
                ),
                child: Text(
                  'Chats',
                  style: TextStyle(
                    color: Get.theme.primaryColorLight,
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
                        homeScreenController.changeChatRoom(homeScreenController.chatHistory[index]);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.black),
                      ),

                      tileColor: Get.theme.disabledColor,
                      trailing:  IconButton(icon: const Icon(Icons.delete), onPressed: () {
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
             Divider(
              height: 2,
              thickness: 2,
              color:Get.theme.primaryColorDark,
            ),
            Container(
              height: 120,
              color: Get.theme.hoverColor.withOpacity(1),
              child: Column(
                children: [
                  ListTile(
                    leading:  Icon(Icons.settings, color: Colors.white),
                    title:  Text('Settings', style: TextStyle(color: Colors.white)),
                    onTap: () async {
                      await Get.to(()=>const Settings());
                     setState(() {
                     });
                    },
                  ),
                  ListTile(
                    leading:  Icon(Icons.exit_to_app_sharp, color: Colors.white),
                    title:  Text('Exit', style: TextStyle(color: Colors.white)),
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
            color: Get.theme.primaryColorDark,
            child: Row(
              children: [
                Expanded(
                  child: TextField(

                    controller: homeScreenController.chat,
                    style: TextStyle(color: Colors.white),
                    decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,

                      hintText: 'Type your message',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
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
                  icon:  Icon(
                    Icons.play_arrow_rounded,
                    color: Get.theme.primaryColor,
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
