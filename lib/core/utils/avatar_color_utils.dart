import 'dart:math';
import 'package:flutter/material.dart';

class AvatarColorUtils {
  static Color backgroundFromName(String name) {
    final hash = name.codeUnits.fold(0, (a, b) => a + b);
    final random = Random(hash);

    return Color.fromARGB(
      255,
      random.nextInt(200) + 30,
      random.nextInt(200) + 30,
      random.nextInt(200) + 30,
    );
  }

  static Color textColorFromBackground(Color bgColor) {
    final luminance = bgColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}