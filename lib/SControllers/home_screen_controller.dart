import 'dart:async';


import 'package:ai_chat/Model/message.dart';
import 'package:ai_chat/gemini_services.dart';
import 'package:ai_chat/local_data_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  TextEditingController chat = TextEditingController();
  RxList chatmsgs = [].obs;
  RxList chatHistory = [].obs;
  TextEditingController dialog = TextEditingController();
  String? tableName;
RxInt? index;
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    tableName = "tempChat";
    chatHistory.addAll(await LocalDataStorage().getTableNames());
    print(chatHistory);
    List<Message> msgs = await LocalDataStorage().getMsgs(
        tableName!);
    // print("index");
int len=msgs.length;
    chatmsgs = msgs.obs;
    index=LocalDataStorage().getTableCountId(msgs[len-1].chatmsg).obs;
    print(index);
    chatmsgs.removeAt(len-1);
    Get.reload();
  }



//methods
  hitApi() async {
    String response = await GeminiServices().GenOutput(chat.text);
    if (response == "") {
      response = "There is some error.";
    }
    index?.value=index!.value-1;
    print(index!.value.toString());
    LocalDataStorage().updateMsg(Message(chatmsg: index!.value.toString(), ai: false,id: 1111), tableName!);
    Message resMsg = Message(
        chatmsg: response, ai: true, id: index!.value);
    chatmsgs.insert(0, resMsg);

    //database
    print("by ai");
    await LocalDataStorage().insertMsg(resMsg, tableName!);
    // List<Message> tasks = await LocalDataStorage().getMsgs(tableName!);
    // for (Message task in tasks) {
    //   print('Task: ${task.chatmsg}, Completed: ${task.ai}, ${task.time}, ${task
    //       .id}');
    // }
  }

  Future<void> addInChatMsgs() async {
    index?.value=index!.value-1;
    print(index!.value.toString());
    LocalDataStorage().updateMsg(Message(chatmsg: index.toString(), ai: false,id: 1111), tableName!);
    Message newMsg = Message(
        chatmsg: chat.text, ai: false, id: index?.value);
    chatmsgs.insert(0, newMsg);
    print(chat.text);
    //database
    print("by ai");
    await LocalDataStorage().insertMsg(newMsg, tableName!);
    // List<Message> tasks = await LocalDataStorage().getMsgs(tableName!);
    // for (Message task in tasks) {
    //   print('Task: ${task.chatmsg}, Completed: ${task.ai}, ${task.time}, ${task
    //       .id}');
    // }
  }

  void clearChat() {
    LocalDataStorage().clearTable(tableName!);
    chatmsgs.clear();
    LocalDataStorage().updateMsg(Message(chatmsg: "1111", ai: false,id: 1111), tableName!);
  }

  void deleteChat(String tableName) {
    LocalDataStorage().deleteTable(tableName);
  }


  // Future<void> newChatInit(String text) async {
  //   tableName = text;
  //   chatHistory.add(tableName);
  //   List<Message> msgs = await LocalDataStorage().getMsgs(
  //       tableName!);
  //   int len=msgs.length;
  //   chatmsgs = msgs.obs;
  //   index=LocalDataStorage().getTableCountId(msgs[len-1].chatmsg).obs;
  //   print(index);
  //
  //   chatmsgs.removeAt(len-1);
  // }
  Future<void> newChatInit(String text) async {
    tableName = text;
    chatHistory.add(tableName);

    // Ensure the table exists or create it
    // await LocalDataStorage().createTableIfNotExists(tableName!);

    // Now proceed to get messages
    List<Message> msgs = await LocalDataStorage().getMsgs(tableName!);
    int len = msgs.length;
    chatmsgs = msgs.obs;
    index = LocalDataStorage().getTableCountId(msgs[len - 1].chatmsg).obs;
    print(index);

    if (len > 0) {
      chatmsgs.removeAt(len - 1);
    }
  }

}