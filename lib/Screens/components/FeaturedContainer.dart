import 'package:appetizer/ProductPage/models/FeatureProvider.dart';
import 'package:appetizer/ProductPage/models/cartProvider.dart';
import 'package:appetizer/login/LoginProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FeatureContainer extends StatefulWidget {
  final int index;
  final bool liked;

  FeatureContainer({Key key, this.index, this.liked}) : super(key: key);

  @override
  _FeatureContainerState createState() => _FeatureContainerState();
}

class _FeatureContainerState extends State<FeatureContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FeatureProvider categoryModel =
        Provider.of<FeatureProvider>(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);
    LoginProvider loginProvider = Provider.of(context, listen: false);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: size.width - 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            width: size.width - 80,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: size.width - 80,
                  height: size.height / 4 - 30,
                  fit: BoxFit.fitWidth,
                  imageUrl: categoryModel.feature[widget.index].url,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
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
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                                text: categoryModel.feature[widget.index].price
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
                        onTap: (isLiked) async {
                          await cartProvider.wishlistLiked(
                              isLiked,
                              loginProvider.user,
                              categoryModel.feature[widget.index].id);
                          return !isLiked;
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(
                  flex: 8,
                ),
                Text(
                  categoryModel.feature[widget.index].name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'NotoSans',
                      fontWeight: FontWeight.bold),
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
                        categoryModel.feature[widget.index].rating,
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
                            fontSize: 12, color: Colors.white.withOpacity(0.4)),
                      ),
                      Spacer(),
                      CartItem(
                        index: widget.index,
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
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
    FeatureProvider featureProvider =
        Provider.of<FeatureProvider>(context, listen: false);
    String id = featureProvider.feature[widget.index].id;
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
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 70,
          height: 32,
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(20)),
          child: isFirstTime
              ? InkWell(
                  onTap: () {
                    cartProvider.firstTime(
                        widget.index, featureProvider.feature[widget.index]);
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        cartProvider.decrement(widget.index,
                            featureProvider.feature[widget.index].id);
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
                        cartProvider.increment(widget.index,
                            featureProvider.feature[widget.index].id);
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
      ),
    );
  }
}
