import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiServices {
  final gemini = Gemini.instance;

  Future<String> GenOutput(String text) async {
    print(text);
    try {
      final value = await gemini.text(text);
      print(value?.output);
      print("scfascazfc");
      return value?.output ?? "";
    } catch (e) {
      print(e);
      return "";
    }
  }
}
