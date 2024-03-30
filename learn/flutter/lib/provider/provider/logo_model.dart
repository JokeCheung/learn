
import 'package:flutter/cupertino.dart';

class LogoModel extends ChangeNotifier{
  bool _flipX=false;
  bool _flipY=false;
  double _size=100.0;

  bool get flipX => _flipX;

  set flipX(bool value) {
    _flipX = value;
    notifyListeners();
  }

  bool get flipY => _flipY;

  set flipY(bool value) {
    _flipY = value;
    notifyListeners();
  }

  double get size => _size;

  set size(double value) {
    _size = value;
    notifyListeners();
  }
}