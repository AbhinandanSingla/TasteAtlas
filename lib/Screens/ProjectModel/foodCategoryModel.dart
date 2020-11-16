import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';

class SelectedCategory extends Model {
  int selectedIndex = 0;
  // final StorageReference _reference = FirebaseStorage.instance.ref();

  SelectIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
