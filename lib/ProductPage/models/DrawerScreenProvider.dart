import 'package:flutter/cupertino.dart';

class DrawerProvider extends ChangeNotifier {
  bool toggle = false;
  var screenDistance = Offset(0, 0);
  var scalefactor = 1.0;
  toggleSwitch() {
    toggle = !toggle;
    if (toggle) {
      screenDistance = Offset(220, 150);
      scalefactor = 0.7;
    } else {
      screenDistance = Offset(0, 0);
      scalefactor = 1.0;
    }
    notifyListeners();
  }

  refresh() {
    notifyListeners();
  }
}
