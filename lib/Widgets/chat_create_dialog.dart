import 'package:ai_chat/SControllers/home_screen_controller.dart';
import 'package:ai_chat/Utility/colors.dart';
import 'package:ai_chat/local_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChatCreateDialog extends StatelessWidget {
  final TextEditingController controller;
  final HomeScreenController homeScreenController;

  const ChatCreateDialog({super.key, required this.controller, required this.homeScreenController});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40, // Adjust the width to fit within the screen
          maxHeight: 280, // Height of the dialog content
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const Gap(10),
              const Text(
                "Enter Chat Name :-",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              const Gap(10),
              SizedBox(
                width: Get.size.width - 120,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: MyColors.chatboxai,
                  ),
                ),
              ),
              const Gap(6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(22),
                  const Text("Mode :", style: TextStyle(fontSize: 16,color: Colors.black)),
                  SizedBox(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => ListTile(
                          leading: Radio<String>(
                            value: "Text",
                            groupValue: homeScreenController.mode.value,
                            onChanged: (value) {
                              homeScreenController.mode.value = value!;
                            },
                            activeColor: Get.theme.hoverColor,
                          ),
                          title: const Text("Text",style: TextStyle(color: Colors.black),),
                          minVerticalPadding: 0,
                          minTileHeight: 25,

                        )),
                        Obx(() => ListTile(
                          leading: Radio<String>(
                            value: "Text/Image",
                            groupValue: homeScreenController.mode.value,
                            onChanged: (value) {
                              homeScreenController.mode.value = value!;
                            },
                            activeColor: Get.theme.hoverColor,
                          ),
                          title: const Text("Text/Image",style: TextStyle(color: Colors.black),),
                          minTileHeight: 25,
                        )),
                        Obx(() => ListTile(
                          leading: Radio<String>(
                            value: "Chat",
                            groupValue: homeScreenController.mode.value,
                            onChanged: (value) {
                              homeScreenController.mode.value = value!;
                            },
                            activeColor: Get.theme.hoverColor,

                          ),
                          title: const Text("Chat",style: TextStyle(color: Colors.black),),
                          minTileHeight: 25,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // LocalDataStorage().initDatabase(controller.text);
                  homeScreenController.newChatCreate(controller.text);
                  controller.clear();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width - 120, 45),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Get.theme.hoverColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Start Chat.."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
