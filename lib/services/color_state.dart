import 'package:flutter/material.dart';

class ColorModel extends ChangeNotifier {
  Color _color = Color(0xff929ae7);

  Color get color => _color;

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }
}
