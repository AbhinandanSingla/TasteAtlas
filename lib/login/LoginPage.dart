import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'LoginProvider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  otpNavigator(BuildContext context) async {
    await Navigator.of(context).pushNamed('/otp');
  }

  GlobalKey <FormState> _phoneKey = GlobalKey<FormState>();

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    print(size.height);
    print(size.width);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/le-buzz-zQLYPVt89d4-unsplash.jpg',
              height: size.height,
              fit: BoxFit.fill,
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
              child: Form(key:_phoneKey,
                child: Container(
                  width: size.width,
                  height: size.height / 3,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
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
                          return TextFormField(controller: _controller,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: providervalue.NumberLength
                                    ? Colors.black
                                    : Color(0xFF69021F),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Color(0xFF69021F),
                                ),
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                    color: Color(0xFF69021F),
                                    fontWeight: FontWeight.normal)),
                            onChanged: (value) {
                              providervalue.phoneLength(value);
                            },
                          );
                        }),
                        Spacer(),
                        Consumer<LoginProvider>(builder: (BuildContext context,
                            LoginProvider providervalue, Widget child) {
                          return FlatButton(
                              onPressed: () {
                                print(_controller.text
                                );
                                if (providervalue.NumberLength) {
                                  providervalue.verifyPhoneNumber(_controller.text);
                                  otpNavigator(context);
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
                              ));
                        }),
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
    _controller.dispose();
  }
}
