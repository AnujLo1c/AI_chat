import 'package:ai_chat/Utility/colors.dart';
import 'package:flutter/material.dart';

class ChatmsgBox extends StatelessWidget {
  final String text;
  final bool ai;

  const ChatmsgBox({super.key, required this.text, required this.ai});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: ai ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          margin: EdgeInsets.only(top: 10, bottom: 10, left: ai ? 2 : 25, right: ai ? 25 : 2),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: ai ? MyColors.chatboxai : MyColors.chatboxmy,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: MyColors.primary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
