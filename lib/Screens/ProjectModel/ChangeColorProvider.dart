import 'package:flutter/cupertino.dart';


class SelectedCategory12 extends ChangeNotifier {
  selectedCategory(int index, int selectedIndex) {
    selectedIndex = index;
    notifyListeners();
    return selectedIndex;
  }
}
