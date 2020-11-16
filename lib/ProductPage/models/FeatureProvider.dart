import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'featuredItem.dart';

class FeatureProvider extends ChangeNotifier {
  List<FeaturedItem> feature = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getFeatureData(List products) async {
    feature.clear();
    await _firestore
        .collection('menu')
        .doc('FeaturedItems')
        .get()
        .then((value) => value.get('Items').forEach((value) {
              for (int i = 0; i < products.length; i++) {
                if (value.toString() == products[i].id) {
                  feature.add(FeaturedItem(
                      id: products[i].id,
                      name: products[i].name,
                      price: products[i].price,
                      rating: products[i].rating,
                      wishlisted: true,
                      desc: products[i].desc,
                      max: products[i].max,
                      min: products[i].min,
                      url: products[i].url,
                      quantity: products[i].quantity,
                      isFirstTime: products[i].isFirstTime));
                }
              }
            }));
    print(feature);
    notifyListeners();
    return feature;
  }
}
