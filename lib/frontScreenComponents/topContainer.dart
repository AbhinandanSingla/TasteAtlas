import 'package:appetizer/ProductPage/models/DrawerScreenProvider.dart';
import 'package:appetizer/ProductPage/models/cartProvider.dart';
import 'package:appetizer/Screens/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:provider/provider.dart';

import '../Contants.dart';

class TopContainer implements SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;

  TopContainer({this.minExtent, this.maxExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    DrawerProvider drawerProvider =
    Provider.of<DrawerProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4 + 40,
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.3 - 10,
                decoration: BoxDecoration(
                    image: DecorationImage(
                          fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/bgmain2.jpg')),
                    color: Colors.green,
                    borderRadius:  BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    InkWell(onTap: (){
                      drawerProvider.toggleSwitch();
                      print('clicking ');
                    },
                      child: Consumer<DrawerProvider>(builder: (BuildContext context,
                          DrawerProvider value, Widget child)=>Container(
                        width: 35,
                        height: 35,
                        child: value.toggle?Image.asset(
                          'assets/images/ic-back_97586.png',color: Colors.deepOrange,
                          scale: 2,
                        ):Image.asset(
                          'assets/images/menu_icon_152581.png',
                          color: Colors.deepOrange,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.94),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      ),
                    ),
                    Spacer(
                      flex: 8,
                    ),
                    Consumer<CartProvider>(builder: (BuildContext context,
                        CartProvider value, Widget child) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CartScreen()),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/images/353439-basket-buy-cart-ecommerce-online-purse-shop-shopping_107515.png',
                                color: Colors.deepOrange,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              bottom: 23,
                              left: 23,
                              child: Container(
                                width: 23,
                                height: 23,
                                child: Center(
                                    child: Text(
                                  cartProvider.cart.length.toString(),
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none),
                                )),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                          color: Colors.grey.shade300)
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                padding:
                    EdgeInsets.only(left: 20, right: 30, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/freeLogo (3).jpg',
                          height: 70,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Taste',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black)),
                                TextSpan(
                                    text: 'atlas',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black))
                              ]),
                            ),
                            Image.asset('assets/images/line.png'),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 20,
                                  color: productColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '4102  Pretty View Lane ',
                                  style: TextStyle(
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Tags(
                          name: 'Meal',
                        ),
                        Tags(
                          name: 'American',
                        ),
                        Tags(
                          name: 'Fast Foods',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/dilvery.png',
                          height: 40,
                          color: productColor,
                        ),
                        Spacer(flex: 1),
                        Text(
                          'Free Delivery',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        Spacer(flex: 4),
                        Image.asset(
                          'assets/images/clock.png',
                          width: 25,
                          height: 40,
                          color: productColor,
                        ),
                        Spacer(flex: 1),
                        Text(
                          '20 - 30min',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/ingredients/star_favourite_15499.png',
                          height: 28,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              height: 2),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '(30+)',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              height: 2),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      null;

  @override
  // TODO: implement vsync
  TickerProvider get vsync => null;
}

class Tags extends StatelessWidget {
  final String name;

  const Tags({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 28,
      child: Center(child: Text(name)),
      decoration: BoxDecoration(
          color: Colors.grey.shade400, borderRadius: BorderRadius.circular(6)),
    );
  }
}
