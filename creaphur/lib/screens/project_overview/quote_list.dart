// text_list.dart
import 'dart:math';

class QuoteList {
  static final List<String> texts = [
    "Welcome to your great work.",
    "Remember to take breaks.",
    "Keep moving forward",
    "Your ideas are appreciated",
    "You are your own worst critic",
    "Your failures don't define you"
  ];

  static String getRandomText() {
    final random = Random();
    return texts[random.nextInt(texts.length)];
  }
}
