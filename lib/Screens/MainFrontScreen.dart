import 'dart:async';

import 'package:appetizer/ProductPage/ProductScreen.dart';
import 'package:appetizer/ProductPage/models/DrawerScreenProvider.dart';
import 'package:appetizer/ProductPage/models/FeatureProvider.dart';
import 'package:appetizer/ProductPage/models/MainScreenProviders.dart';
import 'package:appetizer/ProductPage/models/SurveyProvider.dart';
import 'package:appetizer/ProductPage/models/cartProvider.dart';
import 'package:appetizer/frontScreenComponents/topContainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'SurveyScreen.dart';
import 'components/FeaturedContainer.dart';

class MainFrontScreen extends StatefulWidget {
  @override
  _MainFrontScreenState createState() => _MainFrontScreenState();
}

class _MainFrontScreenState extends State<MainFrontScreen> {
  Future products;
  Future Featured;
  Future images;

  getFuturesFood() async {
    MainScreenProvider providerInstance =
        Provider.of<MainScreenProvider>(context, listen: false);
    FeatureProvider featureInstance =
        Provider.of<FeatureProvider>(context, listen: false);
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    SurveyProvider surveyProvider =
        Provider.of<SurveyProvider>(context, listen: false);
    if (providerInstance.isFirstTimeInit == true) {
      providerInstance.isFirstTimeInit = false;
      await providerInstance.loadAllData();
      providerInstance.categoryData = providerInstance.abc();
      Featured = featureInstance.getFeatureData(providerInstance.products);
      providerInstance.GridContainer =
          providerInstance.convertCategory('Burger');
      cartProvider.basket = providerInstance.Basket;
      surveyProvider.tagList = providerInstance.tagList;
    }

    print('done');
  }

  @override
  void initState() {
    getFuturesFood();
    super.initState();
  }

  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    MainScreenProvider categoryModel =
        Provider.of<MainScreenProvider>(context, listen: false);
    FeatureProvider featureInstance =
        Provider.of<FeatureProvider>(context, listen: false);
    DrawerProvider drawerProvider =
        Provider.of<DrawerProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    SurveyProvider surveyProvider =
        Provider.of<SurveyProvider>(context, listen: false);
    surveyProvider.tag();
    return Consumer<DrawerProvider>(
      builder: (BuildContext context, DrawerProvider value, Widget child) {
        return Stack(
          children: [
            AnimatedContainer(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(0)),
              duration: Duration(milliseconds: 300),
              transform: Matrix4.translationValues(
                  drawerProvider.screenDistance.dx,
                  drawerProvider.screenDistance.dy,
                  0)
                ..scale(drawerProvider.scalefactor),
              child: child,
            ),
            Consumer<MainScreenProvider>(
                builder: (BuildContext context,
                        MainScreenProvider providerValue, Widget child) =>
                    Visibility(
                        visible: providerValue.dataLoaded,
                        child: Container(
                          height: size.height,
                          width: size.width,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'TasteAlas',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.deepOrange),
                              ),
                              Lottie.asset(
                                  'assets/images/Lotties/starting.json'),
                            ],
                          ),
                        )))
          ],
        );
      },
      child: Scaffold(
        floatingActionButton: InkWell(
          child: Image.asset('assets/images/confusedDog.png'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SurveyScreen();
            }));
          },
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              floating: false,
              delegate: TopContainer(
                  maxExtent: size.height * 0.5 - 20, minExtent: 300),
            ),
            FeaturedData(),
            SliverToBoxAdapter(
              child: Consumer<FeatureProvider>(
                builder: (BuildContext context, FeatureProvider value,
                    Widget child) {
                  return Container(
                    height: size.height / 4 - 30,
                    child: FutureBuilder(
                        future: Featured,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              // TODO: Handle this case.
                              break;
                            case ConnectionState.waiting:
                              // TODO: Handle this case.
                              break;
                            case ConnectionState.active:
                              // TODO: Handle this case.
                              break;
                            case ConnectionState.done:
                              // TODO: Handle this case.
                              break;
                          }
                          if (featureInstance.feature.isEmpty) {
                            return ListView.builder(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Shimmer.fromColors(
                                    child: Container(
                                        height: size.height / 4,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        width: size.width - 120,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )),
                                    baseColor: Colors.grey.shade300,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5));
                              },
                            );
                          }
                          return ListView.builder(
                            addAutomaticKeepAlives: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: featureInstance.feature.length == null
                                ? 0
                                : featureInstance.feature.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  data: featureInstance
                                                      .feature[index],
                                                  index: index,
                                                )));
                                  },
                                  child: Hero(
                                    tag: featureInstance.feature[index].id,
                                    child: FeatureContainer(
                                      index: index,
                                    ),
                                  ));
                            },
                          );
                        }),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                child: Consumer<MainScreenProvider>(builder:
                    (BuildContext context, MainScreenProvider value,
                        Widget child) {
                  return FutureBuilder(
                    future: value.categoryData,
                    builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) =>
                        ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.category.length == null
                          ? 0
                          : value.category.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            selectedindex = categoryModel.selectedCategory(
                                index, selectedindex);
                            print(selectedindex);
                            value.GridContainer = categoryModel
                                .convertCategory(snapshot.data[index].name);
                          },
                          child: Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Text(
                                categoryModel.category[index].name,
                                style: TextStyle(
                                    color: selectedindex != null &&
                                            selectedindex == index
                                        ? Colors.black
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
            Consumer<MainScreenProvider>(
              builder: (context, value, child) {
                return FutureBuilder(
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 14,
                        childAspectRatio: size.width / (size.height * 0.6), //
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              print(categoryModel.GridFood[index].id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductPage(
                                          data: categoryModel.GridFood[index],
                                          index: index,
                                        )),
                              );
                            },
                            child: Container(
                              height: size.height * 0.25,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 4,
                                        offset: Offset(0, 0),
                                        blurRadius: 2)
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    height: size.height * 0.25,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: size.height * 0.23,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fitHeight,
                                                imageUrl: categoryModel
                                                    .GridFood[index].url,
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    Lottie.asset(
                                                        'assets/images/Lotties/loading.json'),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Container(
                                            width: size.width / 2 - 30,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                LikeButton(
                                                  size: 23,
                                                  likeBuilder: (bool isLiked) {
                                                    return Image.asset(
                                                      'assets/images/ingredients/heart_like_love_twitter_icon_127132.png',
                                                      color: isLiked
                                                          ? Colors.pink
                                                          : Colors.white,
                                                    );
                                                  },
                                                ),
                                                Container(
                                                  width: 60,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white),
                                                  child: Center(
                                                      child: RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: 'Rs',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .deepOrangeAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text: categoryModel
                                                              .GridFood[index]
                                                              .price
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                    ]),
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 10,
                                          child: CartItem(
                                            index: index,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        categoryModel.GridFood[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 13,
                                          textBaseline: TextBaseline.alphabetic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: categoryModel.GridFood.length,
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class FeaturedData extends StatefulWidget {
  @override
  _FeaturedDataState createState() => _FeaturedDataState();
}

class _FeaturedDataState extends State<FeaturedData> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<FeatureProvider>(
        builder: (BuildContext context, FeatureProvider value, Widget child) =>
            Container(
          margin: EdgeInsets.only(bottom: 20, top: 12),
          padding: EdgeInsets.only(left: 20, right: 20),
          //height: 100,
          //child: Image(image: AssetImage("assets/images/new/bgmain.jpg"),height: 200,width: 200, fit: BoxFit.fitWidth,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Featured Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        child: Center(
                            child: Text(
                          value.feature.length == null
                              ? 0
                              : value.feature.length.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        )),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  final int index;

  const CartItem({Key key, this.index}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    int localIndex = widget.index;

    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
    MainScreenProvider gridProvider =
        Provider.of<MainScreenProvider>(context, listen: false);

    String id = gridProvider.GridFood[widget.index].id;
    cartProvider.basket.forEach((element) {
      if (element.id == id) {
        localIndex = cartProvider.basket.indexOf(element);
      }
    });

    bool isFirstTime = cartProvider.basket[localIndex].isFirstTime;
    int quantity = cartProvider.basket[localIndex].quantity;
    return Consumer<CartProvider>(
      builder: (context, CartProvider instanceV, Widget child) {
        return child;
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                  color: Colors.grey.shade200)
            ],
            // border: Border.all(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        child: isFirstTime
            ? InkWell(
                onTap: () {
                  cartProvider.firstTime(
                      widget.index, gridProvider.GridFood[widget.index]);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.deepOrange,
                    size: 25,
                  ),
                ),
              )
            : Container(
                height: 30,
                width: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        cartProvider.decrement(widget.index,
                            gridProvider.GridFood[widget.index].id);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Center(
                            child: Text(
                          '-',
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        cartProvider.increment(widget.index,
                            gridProvider.GridFood[widget.index].id);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Center(child: Text('+')),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
