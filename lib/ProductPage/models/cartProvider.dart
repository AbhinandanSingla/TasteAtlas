import 'package:appetizer/ProductPage/models/CartModel.dart';
import 'package:appetizer/ProductPage/models/featuredItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List wishlist = [];
  List basket =
      []; // this list will contain the id along with the quantity of the each item to be added
  List cart = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int total = 0;
  bool screenDisable = false;

  //int quantity = 1;
  Dio dio = Dio();
  bool sucess = false;

  wishlistStartup(User user) {
    if (user != null) {
      _firestore
          .collection('user')
          .doc(user.uid.toString())
          .get()
          .then((value) => wishlist = value.get('wishlist'));
    }
    print('$wishlist  ssssssssssssssss');
  }

  firstTime(int index, FeaturedItem item) {
    bool check1 = true;
    bool check2 = false;

    if (check1) {
      print("Entering the first if statement");
      if (cart.isNotEmpty) {
        cart.forEach((element) {
          if (element.id == item.id) {
            check2 = false;
            print("duplicacy of data is not allowed");
          } else {
            print("this is that");
            check2 = true;
          }
        });
      } else {
        check2 = true;
      }
    }

    if (check2) {
      print("Entering the second if statement");
      cart.add(CartModel(
        index: index,
        name: item.name,
        url: item.url,
        price: item.price,
        id: item.id,
        quantity: 1,
        isFirstTime: false,
      ));
      basket.forEach((element) {
        if (element.id == item.id) {
          element.quantity = 1;
          element.isFirstTime = false;
        }
      });
      // basket[index].quantity = 1;

      print("Printing");
      // basket[index].isFirstTime = false;

    }

    notifyListeners();
  }

  increment(int index, String id) {
    basket.forEach((element) {
      if (element.id == id) {
        element.quantity += 1;
      }
    });
    // basket[index].quantity = basket[index].quantity + 1;
    cart.forEach((element) {
      if (element.id == id) {
        element.quantity += 1;

        print(cart);
      }
    });
    notifyListeners();

    print(basket[index].quantity);
  }

  decrement(int index, String id) {
    basket.forEach((element) {
      if (element.id == id) {
        if (element.quantity > 1) {
          element.quantity -= 1;
          cart.forEach((element) {
            if (element.id == id) {
              element.quantity -= 1;
            }
          });
          notifyListeners();
        } else {
          element.isFirstTime = true;
          element.quantity = 0;
          try {
            cart.forEach((element) {
              if (element.id == id) {
                cart.remove(element);
                print(cart);
              }
            });
          } catch (e) {
            print(cart);
            print('list is empty');
          }
          notifyListeners();
        }
      }
    });
  }

  removeItem(int index, String id) {
    basket[index].isFirstTime = true;
    basket.forEach((element) {
      if (element.id == id) {
        element.isFirstTime = true;
        element.quantity = 0;
      }
    });
    try {
      cart.forEach((element) {
        if (element.id == id) {
          cart.remove(element);
          print(cart);
        }
      });
    } catch (e) {
      print(cart);
      print('list is empty');
    }

    notifyListeners();
  }

  totalAmount() {
    total = 0;
    if (cart.length == 0) {
      print('lenght of cart ${cart.length}');
      return total;
    } else {
      cart.forEach((element) {
        print('lenght of cart after total amount  ${cart.length}');
        total += element.quantity * element.price;
        print('total amount $total');
      });
      return total;
    }
  }

  Future placeOrder(User user) async {
    screenDisable = true;
    notifyListeners();
    int orderNumber;
    Map abc = {};
    await _firestore.collection('orderIds').get().then((value) {
      orderNumber = 9600 + value.docs.length + 1;
    });
    await _firestore.collection('orderIds').add({orderNumber.toString(): ''});
    await _firestore
        .collection('currentOrder')
        .doc(orderNumber.toString())
        .set({});

    cart.forEach((element) {
      Map product = {};
      product['name'] = element.name;
      product['url'] = element.url;
      product['quantity'] = element.quantity;
      product['price'] = element.price;
      product['orderedTime'] = DateTime.now();
      product['inProgress'] = true;
      product['delivered'] = false;
      abc[element.id] = product;
    });
    try {
      _firestore.collection('currentOrder').doc(orderNumber.toString()).set({
        user.uid: abc,
      });
      sucess = true;
    } catch (e) {
      sucess = false;
    }
    if (sucess) {
      cart.forEach((element) {
        basket.forEach((abc) {
          if (abc.id == element.id) {
            abc.isFirstTime = true;
            abc.quantity = 0;
          }
        });
      });
      await dio
          .get(
              "https://gurubrahma-smsly-sms-to-india-v1.p.rapidapi.com/sms/transactional/${user.phoneNumber.substring(3)}/Thanks%20for%20Ordering%20from%20TasteAtlas.%0AOrder%20Details%20.....%0ATotal%20item%20%3D%20${cart.length}.%0ATotal%20Amount%20%3D%20$total%2C%0AYour%20order%20will%20be%20on%20your%20table%20within%20in%2020%20minutes..%0AHave%20a%20nice%20day",
              options: Options(headers: {
                "content-type": "application/xml",
                "x-rapidapi-key":
                    "19d15ec7fcmshc65f9f710ed08c6p1eb495jsna131144d59a4",
                "x-rapidapi-host":
                    "gurubrahma-smsly-sms-to-india-v1.p.rapidapi.com",
                "useQueryString": true
              }))
          .then((value) => print('message has been sent $value'));
      _firestore.collection('user').doc(user.uid.toString()).update({
        'currentOrder': FieldValue.arrayUnion([orderNumber.toString()])
      });

      cart.clear();
    }
    screenDisable = false;
    notifyListeners();
    return sucess;
  }

  wishlistLiked(bool isLiked, User user, String productID) {
    if (user == null) {
      if (wishlist.contains(productID)) {
        print('added in removed box');
        wishlist.remove(productID);
      } else {
        if (!isLiked) {
          print('added in liked box');
          wishlist.add(productID);
        } else {
          wishlist.remove(productID);
        }
      }
    } else {
      if (wishlist.contains(productID)) {
        print('added in removed box');

        wishlist.remove(productID);
        _firestore.collection('user').doc(user.uid.toString()).update({
          'wishlist': FieldValue.arrayRemove([productID])
        });
      } else {
        if (!isLiked) {
          print('added in liked box');
          wishlist.add(productID);
          _firestore.collection('user').doc(user.uid.toString()).update({
            'wishlist': FieldValue.arrayUnion([productID])
          });
        } else {
          print('added in removed box');

          wishlist.remove(productID);
          _firestore.collection('user').doc(user.uid.toString()).update({
            'wishlist': FieldValue.arrayRemove([productID])
          });
        }
      }
    }
    print('i am a function that was call on a call $isLiked $user $productID');
  }
}
