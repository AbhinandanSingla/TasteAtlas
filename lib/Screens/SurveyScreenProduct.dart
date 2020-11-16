import 'package:appetizer/ProductPage/models/SurveyProvider.dart';
import 'package:appetizer/ProductPage/models/cartProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SurveyProductScreen extends StatefulWidget {
  @override
  _SurveyProductScreenState createState() => _SurveyProductScreenState();
}

class _SurveyProductScreenState extends State<SurveyProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SurveyProvider surveyProvider = Provider.of<SurveyProvider>(context);
    int itemCount = (surveyProvider.filterList.length / 2).round();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Here what we got'it for you ",
          style: TextStyle(color: Colors.pink),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Navigator.of(context).pop();
            //             // Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/home');
          },
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: size.height * 0.3 - 20,
            margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.pink,
            ),
            child: Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: size.width - 20,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        width: size.width - 20,
                        height: size.height * 0.3 - 20,
                        fit: BoxFit.fitWidth,
                        imageUrl: surveyProvider.filterList[index].url,
                        progressIndicatorBuilder: (context, url,
                                downloadProgress) =>
                            Lottie.asset('assets/images/Lotties/loading.json'),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.white.withOpacity(0.0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.bottomRight,
                      )),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Center(
                                  child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Rs',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.deepOrangeAccent,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: surveyProvider
                                          .filterList[index].price
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))
                                ]),
                              )),
                            ),
                            LikeButton(
                              size: 25,
                              likeBuilder: (bool isLiked) {
                                return Image.asset(
                                  'assets/images/ingredients/heart_like_love_twitter_icon_127132.png',
                                  color: isLiked ? Colors.pink : Colors.white,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 8,
                      ),
                      Text(
                        surveyProvider.filterList[index].name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              surveyProvider.filterList[index].rating,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              'assets/images/ingredients/star_favourite_15499.png',
                              width: 14,
                            ),
                            Text(
                              '(+20)',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.4)),
                            ),
                            Spacer(),
                            CartItem(
                              index: index,
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
    SurveyProvider surveyProvider =
        Provider.of<SurveyProvider>(context, listen: false);
    String id = surveyProvider.filterList[widget.index].id;
    cartProvider.basket.forEach((element) {
      if (element.id == id) {
        localIndex = cartProvider.basket.indexOf(element);
      }
    });

    bool isFirstTime = cartProvider.basket[localIndex].isFirstTime;
    int quantity = cartProvider.basket[localIndex].quantity;
    return Consumer<CartProvider>(
      builder: (context, CartProvider instanceV, Widget child) {
        print(isFirstTime);
        return child;
      },
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        child: isFirstTime
            ? InkWell(
                onTap: () {
                  cartProvider.firstTime(
                      widget.index, surveyProvider.filterList[widget.index]);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '+',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  InkWell(
                    onTap: () {
                      cartProvider.decrement(widget.index, id);
                    },
                    child: Container(
                      width: 25,
                      height: 30,
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
                        color: Colors.pink, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      cartProvider.increment(widget.index, id);
                    },
                    child: Container(
                      width: 25,
                      height: 30,
                      child: Center(child: Text('+')),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
