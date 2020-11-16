import 'package:appetizer/ProductPage/models/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Contants.dart';
import 'Components/TopContainer.dart';
import 'models/featuredItem.dart';

class ProductPage extends StatefulWidget {
  final FeaturedItem data;
  final int index;

  const ProductPage({Key key, this.data, this.index}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);

    int localIndex = widget.index;

    String id = widget.data.id;
    cartProvider.basket.forEach((element) {

      if (element.id == id) {
        localIndex = cartProvider.basket.indexOf(element);
        print(element.id);
        print(id);
        print(localIndex);
      }
    });

    bool isFirstTime = cartProvider.basket[localIndex].isFirstTime;
    print("${widget.data.url}");
    Size size = MediaQuery.of(context).size;
    print(size.height * 0.4 - 12);
    print(size.width);
    return Scaffold(
      floatingActionButton: Visibility(
        child: InkWell(
          child: AddToCartButton(size),
          onTap: () {
            cartProvider.firstTime(widget.index, widget.data);
          },
        ),
        visible: isFirstTime,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopContainer(id: widget.data.id,
                url: widget.data.url,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.data.name,
                      style: TextStyle(
                          fontSize: 30, fontFamily: 'PlayfairDisplay'),
                    ),
                    Image.asset('assets/images/line.png'),
                    Text(
                      widget.data.desc,
                      style: TextStyle(color: Colors.black54, height: 1.5),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Quantity',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: '\$',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.data.price.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                        Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 4,
                                    blurRadius: 12,
                                    offset: Offset(0, 0))
                              ],
                              borderRadius: BorderRadius.circular(30),
                              color: backgroundProduct,
                            ),
                            child: Quantity(
                              index: widget.index,
                              data: widget.data,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Choice of Add On',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Image.asset(
                                      'assets/images/ingredients/redpepper.png'),
                                ),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: Offset(0, 0),
                                          blurRadius: 12,
                                          spreadRadius: 3)
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: backgroundProduct),
                              ),
                              Text(
                                'Pepper julienned',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '+\$2.30',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: backgroundProduct,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: productColor, width: 2)),
                                child: Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }

  Container AddToCartButton(Size size) {
    return Container(
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag,
            color: backgroundProduct,
          ),
          Text(
            'Add to cart',
            style: TextStyle(
              color: backgroundProduct,
            ),
          )
        ],
      )),
      width: size.width / 2,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.pink, borderRadius: BorderRadius.circular(100)),
    );
  }
}

class Quantity extends StatefulWidget {
  final int min;
  final int max;
  final int index;
  final FeaturedItem data;

  const Quantity({Key key, this.min, this.max, this.index, this.data})
      : super(key: key);

  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  @override
  Widget build(BuildContext context) {
    int localIndex = widget.index;
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);

    String id = widget.data.id;
    cartProvider.basket.forEach((element) {
      if (element.id == id) {
        localIndex = cartProvider.basket.indexOf(element);
      }
    });

    bool isFirstTime = cartProvider.basket[localIndex].isFirstTime;
    int quantity = cartProvider.basket[localIndex].quantity;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            cartProvider.decrement(0,
                widget.data.id);
          },
          child: Container(
            width: 35,
            child: Center(
                child: Text(
              '-',
              style: TextStyle(color: backgroundProduct, fontSize: 30),
            )),
            height: 35,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(40)),
          ),
        ),
        Text(
          isFirstTime ? '0' : quantity.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            if (isFirstTime == false) {
              cartProvider.increment(0,
                widget.data.id);
            } else {
              cartProvider.firstTime(0, widget.data);
            }
          },
          child: Container(
            width: 35,
            child: Center(
                child: Text(
              '+',
              style: TextStyle(color: backgroundProduct, fontSize: 20),
            )),
            height: 35,
            decoration: BoxDecoration(
                color: Colors.pink,borderRadius: BorderRadius.circular(40)),
          ),
        ),
      ],
    );
  }
}
