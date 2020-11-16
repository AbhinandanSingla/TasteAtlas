import 'package:appetizer/ProductPage/models/TimeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'LoginProvider.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OtpTimerProvider otpTimerProvider =
        Provider.of<OtpTimerProvider>(context, listen: false);
    otpTimerProvider.timer();
  }

  TextEditingController _OtpController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/le-buzz-zQLYPVt89d4-unsplash.jpg',
              height: size.height,
              fit: BoxFit.fitHeight,
            ),
            Container(
                margin: EdgeInsets.only(top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                          shadows: [
                            BoxShadow(
                                offset: Offset(2, 4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                color: Colors.grey)
                          ],
                          color: Color(0xFF69021F),
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                          shadows: [
                            BoxShadow(
                                offset: Offset(2, 4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                color: Colors.grey)
                          ],
                          color: Color(0xFF69021F),
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Positioned(
              bottom: 0,
              child: Form(
                key: _globalKey,
                child: Container(
                  width: size.width,
                  height: size.height / 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Color(0xFF69021F),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(
                                    offset: Offset(2, 4),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    color: Colors.grey)
                              ]),
                        ),
                        Spacer(),
                        Consumer<LoginProvider>(builder: (BuildContext context,
                            LoginProvider providervalue, Widget child) {
                          return TextFormField(
                            controller: _OtpController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                color: providervalue.smsCode
                                    ? Colors.black
                                    : Color(0xFF69021F),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.timer,
                                  color: Color(0xFF69021F),
                                ),
                                hintText: 'Otp',
                                hintStyle: TextStyle(
                                    color: Color(0xFF69021F),
                                    fontWeight: FontWeight.normal)),
                          );
                        }),
                        Spacer(),
                        Consumer<OtpTimerProvider>(builder:
                            (BuildContext context,
                                OtpTimerProvider providervalue, Widget child) {
                          return Center(
                              child: Text(
                            'Resending Otp in ${providervalue.OtpTime.toString()}',
                            style: TextStyle(color: Color(0xFF69021F)),
                          ));
                        }),
                        Spacer(),
                        FlatButton(
                            onPressed: () {
                              print(_OtpController.text);
                              if (loginProvider.smsCode) {
                                loginProvider
                                    .signInWithPhoneNumber(_OtpController.text)
                                    .then((e) {
                                  print(
                                      '${loginProvider.verified}  jjjjjjjjjjjjjj');
                                  loginProvider.verified
                                      ? Navigator.popAndPushNamed(
                                          context, '/home')
                                      : Navigator.popAndPushNamed(
                                          context, '/adduser');
                                }).catchError((e) {
                                  print(e);
                                });
                              }
                            },
                            child: Container(
                              width: size.width - 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFF69021F)),
                              child: Center(
                                  child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            )),
                        Spacer()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _OtpController.dispose();
  }
}
