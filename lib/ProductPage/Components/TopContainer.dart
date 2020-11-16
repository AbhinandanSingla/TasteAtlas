import 'package:appetizer/ProductPage/models/cartProvider.dart';
import 'package:appetizer/Screens/cartScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class TopContainer extends StatelessWidget {
  final String url;
  final String id;

  TopContainer({Key key, this.url, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4 - 12,
      child: Stack(
        children: [
          Stack(
            children: [
              Hero(
                tag: id,
                child: Container(
                    height: size.height * 0.4 - 37,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: CachedNetworkImage(
                        width: size.width,
                        fit: BoxFit.fitWidth,
                        imageUrl: url,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
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
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Spacer(
                      flex: 8,
                    ),
                    InkWell(
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
                            child: Icon(
                              Icons.shopping_bag,
                              color: Colors.pink,
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
                    ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(
                  flex: 1,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            offset: Offset(0, 2),
                            blurRadius: 1)
                      ]),
                  width: size.width * 0.3,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '4.5',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        'assets/images/ingredients/star_favourite_15499.png',
                        width: 20,
                      ),
                      Text('(+20)')
                    ],
                  ),
                ),
                Spacer(
                  flex: 8,
                ),
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: LikeButton(
                      size: 30,
                    )),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
