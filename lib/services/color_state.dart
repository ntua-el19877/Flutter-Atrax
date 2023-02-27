import 'package:flutter/material.dart';

class ColorModel extends ChangeNotifier {
  Map<String, Color> _colors = {};

  Color getColor(String index) {
    return _colors[index] ?? Color(0xff929ae7);
  }

  void insertColor(String index) {
    _colors.addAll({index: Color(0xff929ae7)});
  }

  void deleteColor(String index) {
    _colors.remove(index);
  }

  void setColor(Color color, String index) {
    _colors[index] = color;
    notifyListeners();
  }

  IconData getIcon(String index) {
    if (_colors[index] == Color(0xff929ae7)) {
      return Icons.check_box_outline_blank;
    } else if (_colors[index] == Color(0xff1f8a87))
      return Icons.check_box_rounded;
    else
      return Icons.check_box_outline_blank;
  }
}
