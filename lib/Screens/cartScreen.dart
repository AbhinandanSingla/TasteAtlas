import 'package:appetizer/ProductPage/models/cartProvider.dart';
import 'package:appetizer/login/LoginPage.dart';
import 'package:appetizer/login/LoginProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('My Cart'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset(
            'assets/images/ic-back_97586.png',
            color: Colors.white,
            scale: 2,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF8F7F3),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Your Food Cart',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  // Image.asset('assets/images/line.png'),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<CartProvider>(
                    builder: (BuildContext context, CartProvider value,
                        Widget child) {
                      return Container(
                        height: size.height / 2 + 20,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: cartProvider.cart.length == null
                              ? 0
                              : cartProvider.cart.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              onDismissed: (DismissDirection direction) {
                                print(direction);
                                cartProvider.removeItem(
                                    cartProvider.cart[index].index,
                                    cartProvider.cart[index].id);
                              },
                              secondaryBackground: slideRightBackground(),
                              background: Container(),
                              child: Container(
                                height: 100,
                                width: size.width - 20,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                          offset: Offset(0, 0))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              height: 80,
                                              fit: BoxFit.fitHeight,
                                              imageUrl:
                                                  cartProvider.cart[index].url,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 152,
                                              child: Text(cartProvider
                                                  .cart[index].name),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: 'Rs',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .deepOrange)),
                                                    TextSpan(
                                                        text: cartProvider
                                                            .cart[index].price
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                  ]),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                QuantityController(
                                                  index: index,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 4,
                                      top: 4,
                                      child: InkWell(
                                        onTap: () {
                                          cartProvider.removeItem(index,
                                              cartProvider.cart[index].id);
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                            );
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              maxChildSize: 0.7,
              minChildSize: 0.2,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                int CartTotal = 0;
                double tax = 5 / 100;
                double SubTotal = 0;
                CartTotal = cartProvider.totalAmount();
                tax = double.parse((CartTotal * tax).toStringAsFixed(2));
                SubTotal = CartTotal + tax;
                // print(CartTotal.toString());

                return Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 2)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, top: 50, left: 20),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          'assets/images/line.png',
                          alignment: Alignment.centerLeft,
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        total('Cart Total', 'Rs${CartTotal.toString()}'),
                        total('Tax', 'Rs${tax.toString()}'),
                        total(
                            'Items Total', cartProvider.cart.length.toString()),
                        total('Sub Total', '${SubTotal}'),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          height: 100,
                          width: size.width - 50,
                          decoration: BoxDecoration(
                              color: Color(0xFFF4EFF9),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Payment',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        boxShadow: [
                                          // BoxShadow(
                                          //     color: Colors.grey,
                                          //     offset: Offset(0, 0),
                                          //     spreadRadius: 2,
                                          //     blurRadius: 2)
                                        ]),
                                    child: InkWell(
                                      onTap: () {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                backgroundColor:
                                                    Color(0xFFF4EFF9)
                                                        .withOpacity(0.8),
                                                content: Text(
                                                  'This feature is coming soon',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 15),
                                                )));
                                      },
                                      child: Image.asset(
                                        'assets/images/pencil.png',
                                        scale: 1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Lottie.asset(
                                      'assets/images/Lotties/payment.json',
                                      width: 30,
                                      height: 30),
                                  Text('Pay on Order Received')
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        cartProvider.cart.length == 0
                            ? Container()
                            : ConfirmationSlider(
                                onConfirmation: () {
                                  if (loginProvider.user == null) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return LoginPage();
                                    }));
                                  } else {
                                    cartProvider
                                        .placeOrder(loginProvider.user)
                                        .then((value) => value
                                            ? Navigator.of(context).pop()
                                            : print('errror maar gyaaa'));
                                  }
                                },
                                width: size.width - 40,
                                backgroundColorEnd: Colors.pink,
                                backgroundColor: Colors.white,
                                iconColor: Colors.black,
                                foregroundColor: Colors.white,
                                height: 100,
                                text: 'Slide to Order',
                                shadow: BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0)),
                              )
                      ],
                    ),
                  ),
                );
              },
            ),
            CartSplash(
              size: size,
            )
          ],
        ),
      ),
    );
  }

  Container total(String name, String value) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: Colors.black12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 20, color: Colors.pink),
          ),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete_rounded,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}

class QuantityController extends StatefulWidget {
  final int index;

  const QuantityController({Key key, this.index}) : super(key: key);

  @override
  _QuantityControllerState createState() => _QuantityControllerState();
}

class _QuantityControllerState extends State<QuantityController> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.pink, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              cartProvider.increment(cartProvider.cart[widget.index].index,
                  cartProvider.cart[widget.index].id);
            },
            child: Container(
              height: 20,
              width: 20,
              child: Center(child: Text('+')),
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          Text(
            cartProvider.cart[widget.index].quantity.toString(),
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              cartProvider.decrement(cartProvider.cart[widget.index].index,
                  cartProvider.cart[widget.index].id);
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                  child: Text(
                '-',
                style: TextStyle(
                  fontSize: 15,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class CartSplash extends StatelessWidget {
  final Size size;

  const CartSplash({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _isScreenDisable =
        context.select<CartProvider, bool>((value) => value.screenDisable);
    return Visibility(
      visible: _isScreenDisable,
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Processeding your Please wait...',
              style: TextStyle(color: Color(0xff4B9DB5), fontSize: 15),
            ),
            Center(
                child: Lottie.asset('assets/images/Lotties/OrderCooking.json',
                    width: size.width * 0.5)),
          ],
        ),
      ),
    );
  }
}
