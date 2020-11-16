import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderScreenProvider extends ChangeNotifier {
  bool sucessDelivered = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  delivered(String orderId, String uid, Map productList) async {
    sucessDelivered = true;
    notifyListeners();
    productList.forEach((key, value) {
      value["delivered"] = true;
      print(value);
    });
    await _firestore
        .collection('currentOrder')
        .doc(orderId)
        .update({uid: productList});
    String date =
        '${DateTime.now().day.toString()}|${DateTime.now().month.toString()}|${DateTime.now().year.toString()}';
    await _firestore.collection('orderHistory').doc(date).update({
      orderId: {uid: productList}
    }).catchError((e) {
      _firestore.collection('orderHistory').doc(date).set({
        orderId: {uid: productList}
      });
    });
    await _firestore.collection('currentOrder').doc(orderId).delete();

    await _firestore.collection('user').doc(uid).update({
      'currentOrder': FieldValue.arrayRemove([orderId])
    });
    sucessDelivered = false;
    notifyListeners();
  }
}
