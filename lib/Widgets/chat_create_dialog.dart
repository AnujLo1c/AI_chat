import 'package:ai_chat/Utility/colors.dart';
import 'package:ai_chat/local_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class ChatCreateDialog extends StatelessWidget {
  final TextEditingController controller;

  const ChatCreateDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.sidepanel,
        ),
        height: 180,
        child: Column(
          children: [
            const Gap(10),
            const Text(
              "Enter Chat Name :-",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            SizedBox(
              width: Get.size.width - 120,
              child: TextField(
                controller: controller, // Ensure this is properly linked
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  filled: true,
                  fillColor: MyColors.chatboxai,
                ),
              ),
            ),
            const Gap(10),
            ElevatedButton(
              onPressed: () {
                // Reset or reuse the controller as needed
                LocalDataStorage().initDatabase(controller.text);
                controller.clear(); // Clear after using
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(Get.width - 120, 45),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: MyColors.chatboxmy,
                foregroundColor: MyColors.primary,
              ),
              child: const Text("Start Chat.."),
            ),
          ],
        ),
      ),
    );
  }
}
