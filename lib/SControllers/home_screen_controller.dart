import 'dart:async';

import 'package:ai_chat/Model/message.dart';
import 'package:ai_chat/gemini_services.dart';
import 'package:ai_chat/local_data_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreenController extends GetxController {
  TextEditingController chat = TextEditingController();
  RxList<Message> chatmsgs = <Message>[].obs;
  RxList<String> chatHistory = <String>[].obs;
  TextEditingController dialog = TextEditingController();
  String? tableName;
  RxInt index = 1110.obs;
  var mode="Text".obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    tableName = "tempChat";
    chatHistory.addAll(await LocalDataStorage().getTableNames());
    List<Message> msgs = await LocalDataStorage().getMsgs(tableName!);
    chatmsgs.value = msgs;
    if (msgs.isNotEmpty) {
      index.value = LocalDataStorage().getTableCountId(msgs.last.chatmsg);
      chatmsgs.removeLast();
    }
  }

  Future<void> hitApi() async {
    String response = await GeminiServices().GenOutput(chat.text);
    if (response == "") {
      response = "There is some error.";
    }
    index.value -= 1;
    await LocalDataStorage().updateMsg(
        Message(chatmsg: index.value.toString(), ai: false, id: 1111),
        tableName!);
    Message resMsg = Message(chatmsg: response, ai: true, id: index.value);
    chatmsgs.insert(0, resMsg);
    await LocalDataStorage().insertMsg(resMsg, tableName!);
  }

  Future<void> addInChatMsgs() async {
    index.value -= 1;
    Message newMsg = Message(chatmsg: chat.text, ai: false, id: index.value);
    // await LocalDataStorage().updateMsg(
    //     newMsg, tableName!);
    chatmsgs.insert(0, newMsg);
    await LocalDataStorage().insertMsg(newMsg, tableName!);
  }

  void clearChat() {
    LocalDataStorage().clearTable(tableName!);
    chatmsgs.clear();
    LocalDataStorage()
        .updateMsg(Message(chatmsg: "1111", ai: false, id: 1111), tableName!);
  }

  void deleteChat(String tableName) {
    LocalDataStorage().deleteTable(tableName);
  }

  Future<void> newChatCreate(String text) async {
    tableName = text;
    chatHistory.add(tableName!);
    final db = await LocalDataStorage().database;
    //
    await LocalDataStorage().createTableIfNotExists(db, tableName!,mode.value);
    await LocalDataStorage()
        .insertMsg(Message(chatmsg: "1110", ai: false, id: 1111), tableName!);
    //
    chatmsgs.clear();
    index.value = 1111;
  }

  Future<void> changeChatRoom(String name) async {
    tableName = name;
    List<Message> temp = await LocalDataStorage().getMsgs(tableName!);
    chatmsgs.value = temp;
    if (temp.isNotEmpty) {
      index.value = LocalDataStorage().getTableCountId(temp.last.chatmsg);
    } else {
      index.value = 1110;
    }
    if (temp.isNotEmpty) {
      chatmsgs.removeLast();
    }
    update();
    Get.close(1);
  }
  void changeMode(String newMode) {
    mode.value = newMode;
  }
}
