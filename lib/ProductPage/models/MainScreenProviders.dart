import 'package:appetizer/ProductPage/models/Basket.dart';
import 'package:appetizer/ProductPage/models/ProductsModel.dart';
import 'package:appetizer/ProductPage/models/TagModel.dart';
import 'package:appetizer/ProductPage/models/category.dart';
import 'package:appetizer/ProductPage/models/featuredItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class MainScreenProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageReference _reference = FirebaseStorage.instance.ref();

  List category = [];
  List products = [];
  List ImagesUrl = [];
  List GridFood = [];
  List<BasketModel> Basket = [];
  List tagList = [];
  bool isFirstTimeInit = true;
  Future categoryData;
  Future product;
  Future Featured;
  Future images;
  Future GridContainer;

  bool dataLoaded = true;

  loadAllData() async {
    await getProducts(); // It will load all our product to products list
    print("First await done");
    // await getUrl(); // After loading product we will modify url properties of the product list fetch in first step
    // print("Second await done");
    await getCategory(); // then we'll load all our categories
    print("Third await done");
    //return categoryList;

    categoryData = abc();
    GridContainer = convertCategory('Burger');
    dataLoaded = false;
  }

  getProducts() async {
    products.clear();
    await _firestore
        .collection('menu')
        .doc('Products')
        .get()
        .then((value) => value.data().forEach((key, value) {
              for (var entry in value.entries) {
                print(entry.key);
                print(entry.value);
              }
              products.add(ProductsModel(
                  name: value['name'],
                  url: value['url'],
                  price: value['price'],
                  id: key.toString(),
                  desc: value['desc'],
                  max: value['max'],
                  min: value['min'],
                  rating: value['rating'].toString(),
                  isFirstTime: true,
                  tags: value['tag'],
                  quantity: 0));
              Basket.add(BasketModel(
                  id: key.toString(),
                  quantity: 0,
                  name: value['name'],
                  isFirstTime: true));
              tagList.add(tagModel(
                  price: value['price'],
                  id: key.toString(),
                  priority: 0,
                  tag: value['tag'],
                  name: value['name'],
                  rating: value['rating'].toString(),
                  isFirstTime: true,
                  url: value['url']));
              print(Basket);
            }));

    return products;
  }

  // //
  // getUrl() async {
  //   try {
  //     for (int i = 0; i < products.length; i++) {
  //       try {
  //         await _reference
  //             .child(products[i].url)
  //             .getDownloadURL()
  //             .then((value) {
  //           print(products[i].url);
  //           _firestore.collection('menu').doc('Products').update({
  //             products[i].id: {'url': value}
  //           });
  //
  //         });
  //       } catch (e) {
  //         print('${e} +++++++++++++++++++ ${products[i].url}');
  //       }

  //       tagList.add(tagModel(
  //           price: products[i].price,
  //           id: products[i].id,
  //           priority: 0,
  //           tag: products[i].tags,
  //           name: products[i].name,
  //           rating: products[i].rating,
  //           isFirstTime: products[i].isFirstTime,
  //           url: products[i].url));
  //       print(Basket);
  //     }
  //   } catch (e) {
  //     print('$e++++++++++++++++++++++++++++++++++++');
  //   }
  // } // also created a duplicate basket list which will help in cart UI

  getCategory() async {
    category.clear();
    await _firestore
        .collection('menu')
        .doc('category')
        .get()
        .then((value) => value.data().forEach((key, value) {
              category.add(CategoryModel(name: key.toString(), items: value));
              print(value);
            }));

    return category;
  }

  getGridProducts() async {
    await _firestore
        .collection('menu')
        .doc('category')
        .get()
        .then((value) => value.get('Burger'));
  } // to load all ore grid products

  getProductlist() {
    return products;
  }

  convertCategory(String name) async {
    GridFood.clear();
    category.forEach((element) {
      if (element.name == name) {
        element.items.forEach((value) {
          for (int i = 0; i < products.length; i++) {
            if (products[i].id.toString() == value.toString()) {
              GridFood.add(FeaturedItem(
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
        });
      }
    });
    notifyListeners();
    return GridFood;
  }

  selectedCategory(int index, int selectedIndex) {
    selectedIndex = index;
    notifyListeners();
    return selectedIndex;
  }

  abc() async {
    return category;
  }
}
