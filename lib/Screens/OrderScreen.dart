import 'package:appetizer/ProductPage/models/OrderScreenProvider.dart';
import 'package:appetizer/login/LoginProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List orderIds = [];
  bool inProgress = false;
  Future getOrders;
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('rebuilding ');
    print(orderIds.length);
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    OrderScreenProvider orderScreenprovider =
        Provider.of<OrderScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade700,
        centerTitle: true,
        title: Text('Orders'),
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: _firestore
                .collection('user')
                .doc(loginProvider.user.uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null) {
                return Text("you haven't place any order Yet");
              }
              if (snapshot.data['currentOrder'].length == null) {
                return Text("you haven't place any order Yet");
              }
              orderIds = snapshot.data['currentOrder'];
              return ListView.builder(
                itemCount: snapshot.data['currentOrder'].length,
                itemBuilder: (BuildContext context, int index) {
                  return StreamBuilder(
                    stream: _firestore
                        .collection('currentOrder')
                        .doc(orderIds[index].toString())
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.data == null) {
                        return Text('Loading dataaaa');
                      }
                      DocumentSnapshot documentSnapshot = snapshot.data;
                      print(documentSnapshot.id);
                      String orderId = documentSnapshot.id;
                      Map abc = documentSnapshot.data()[loginProvider.user.uid];
                      print(abc);
                      Timestamp dateTime = abc.values.first['orderedTime'];
                      inProgress = abc.values.first['inProgress'];
                      totalAmount = 0;
                      double tax = 5 / 100;
                      int CartTotal = 0;
                      abc.forEach((key, value) {
                        CartTotal += value['price'] * value['quantity'];
                      });
                      tax = double.parse((CartTotal * tax).toStringAsFixed(2));
                      totalAmount = CartTotal + tax;

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFF4EFF9),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OrderID : $orderId | ${dateTime.toDate().hour}:${dateTime.toDate().minute}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Vollkorn'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ))),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                itemCount: abc.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  String key = abc.keys.elementAt(index);
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width / 2,
                                        child: Text(
                                          '${abc[key]['quantity']} X ${abc[key]['name']}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(),
                                        ),
                                      ),
                                      abc[key]['inProgress']
                                          ? Text(
                                              'Cooking',
                                              style: TextStyle(
                                                  fontFamily: 'jaldi',
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text('OrderCooked'),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Total Amount : Rs ${totalAmount.toString()}'),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                if (!inProgress) {
                                  orderScreenprovider.delivered(
                                      orderId, loginProvider.user.uid, abc);
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Please your order will be ready soon '),
                                  ));
                                }
                              },
                              child: Container(
                                width: size.width - 50,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                    child: Text(
                                  'Received',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          Consumer<OrderScreenProvider>(
            builder: (BuildContext context, OrderScreenProvider providerValue,
                Widget child) {
              print(providerValue.sucessDelivered);
              return Visibility(
                visible: providerValue.sucessDelivered,
                child: Container(
                  height: size.height,
                  color: Colors.white,
                  child: Lottie.asset(
                      'assets/images/Lotties/cartAnimation.json',
                      width: size.width - 60),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
