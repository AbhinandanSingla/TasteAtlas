import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginProvider.dart';

class Adduser extends StatefulWidget {
  @override
  _AdduserState createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
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
                  height: size.height / 2,
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
                          'New User',
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
                        TextFormField(
                          controller: _firstnameController,
                          style: TextStyle(),
                          decoration: InputDecoration(
                              hintText: 'First name',
                              hintStyle: TextStyle(color: Color(0xFF69021F))),
                        ),
                        TextFormField(
                          controller: _surnameController,
                          style: TextStyle(),
                          decoration: InputDecoration(
                              hintText: 'Surname',
                              hintStyle: TextStyle(color: Color(0xFF69021F))),
                        ),
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                              hintText: 'Address',
                              hintStyle: TextStyle(color: Color(0xFF69021F))),
                          maxLines: 4,
                        ),
                        Spacer(),
                        Consumer<LoginProvider>(builder: (BuildContext context,
                            LoginProvider providervalue, Widget child) {
                          return FlatButton(
                              onPressed: () {
                                print(_firstnameController.text);
                                if (_firstnameController.text.length != 0 &&
                                    _addressController.text.length != 0) {
                                  loginProvider.addUser(
                                      _firstnameController.text,
                                      _surnameController.text,
                                      _addressController.text);
                                  Navigator.pushNamed(context, '/home');
                                  print('abc');
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
    _addressController.dispose();
    _addressController.dispose();
    _surnameController.dispose();
  }
}
