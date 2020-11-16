import 'dart:async';
import 'dart:ui';

import 'contants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

bool switcher = false;
bool showOtp = false;
bool _enablePhoneNumber = true;
bool falseInput = true;
bool enableOtp = false;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _LoginUIState extends State<LoginUI> {
  final _phoneNumberController = TextEditingController();
  final _smscontroller = TextEditingController();
  final GlobalKey<ScaffoldState> _scafold = GlobalKey<ScaffoldState>();
  String _message = '';
  String _verificationID = '';
  Timer _timer;
  static var _OtpTime = 120;
  bool Lock = false;

  void timer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_OtpTime > 0) {
          Lock = true;
          _OtpTime--;
        } else {
          Lock = false;
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBar _snaku = SnackBar(
      content: Text('invalid phone Number ....'),
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
    Size size = MediaQuery.of(context).size;
    debugPrint(size.toString());
    return Scaffold(
        key: _scafold,
        backgroundColor: kBackground,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(kpadding),
              child: Column(
                children: [
                  TopCon(size: size),
                  Stack(alignment: Alignment.bottomCenter, children: [
                    foregroundBack(size: size),
                    Container(
                      // margin: EdgeInsets.only(top: 6),
                      width: size.width,
                      height: size.height - (size.height / 3),
                      decoration: BoxDecoration(
                          color: kForeground,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Login to Continue',
                              style: TextStyle(
                                  color: kButton,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: kmargin * 15, right: kmargin * 15),
                            padding: EdgeInsets.only(
                                left: kpadding * 8,
                                right: kpadding * 8,
                                top: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: falseInput ? kBorder : kBackground,
                                    style: BorderStyle.solid)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _phoneNumberController,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.length != 10) {
                                          falseInput = false;
                                        } else {
                                          falseInput = true;
                                        }
                                      });
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.phone),
                                        hintText: 'Enter your phone Number...',
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabled: _enablePhoneNumber,
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: kBorder)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          showOtp
                              ? Container(
                            margin: EdgeInsets.only(
                                left: kmargin * 15, right: kmargin * 15),
                            padding: EdgeInsets.only(
                                left: kpadding * 10,
                                right: kpadding * 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: kBorder,
                                    style: BorderStyle.solid)),
                            child: TextField(
                              controller: _smscontroller,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: 'Enter your OTP',
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: kBorder)),
                            ),
                          )
                              : SizedBox(),
                          showOtp ? Text('Otp $_OtpTime') : SizedBox(),
                          SizedBox(
                            height: 40,
                          ),
                          showOtp
                              ? Container(
                            width: size.width - 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kButton),
                            child: FlatButton(
                              onPressed: () {
                                _signInWithPhoneNumber();
                              },
                              child: Text('Submit Otp'),
                            ),
                          )
                              : Container(
                            width: size.width - 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kButton),
                            child: FlatButton(
                              onPressed: Lock
                                  ? null
                                  : () {
                                if (_phoneNumberController
                                    .text.length !=
                                    10) {
                                  _scafold.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Wrong PhoneNumber Please check'),
                                    duration: Duration(seconds: 1),
                                  ));
                                } else {
                                  _verifyPhoneNumber();
                                  timer();
                                }
                              },
                              child: Text(
                                'Get Otp',
                                style: TextStyle(color: kForeground),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 70),
                              child: FlatButton(
                                child: Text('need help..?'),
                                color: kForeground,
                                onPressed: () {
                                  _scafold.currentState.showSnackBar(_snaku);
                                },
                              ))
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
  void checkUser()async{
    try{
      await _firestore.doc("user/${_auth.currentUser.uid}").get().then((value) {
        if(value.exists){
          _firestore.collection('user').doc(_auth.currentUser.uid).update({
            "lastlogin":DateTime.now()
          });
        }else{
          _firestore.collection('user').doc(_auth.currentUser.uid).set({
            'phoneNumber':_phoneNumberController.text,
            'uid': _auth.currentUser.uid,
            'lastlogin':DateTime.now()
          });
        }
      });
    }catch(e){
      debugPrint('error in firebase $e');
    }
  }
  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      _timer.cancel();
      Navigator.pushNamed(context, '/signout');
      checkUser();
      _scafold.currentState.showSnackBar(
        SnackBar(
          content: Text(
              "Phone number automatically verified and user signed in: $phoneAuthCredential"),
          duration: Duration(seconds: 1000),
        ),
      );
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      setState(() {
        _message =
        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      setState(() {
        showOtp = true;
      });
      _scafold.currentState.showSnackBar(
        SnackBar(
          content: Text('Please check your phone for the verification code.'),
        ),
      );
      _verificationID = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationID = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + _phoneNumberController.text,
          timeout: Duration(seconds: 120),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      _scafold.currentState.showSnackBar(SnackBar(
        content: Text("Failed to Verify Phone Number"),
      ));
    }
  }

  void _signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationID, smsCode: _smscontroller.text);
      final User user = (await _auth.signInWithCredential(credential)).user;
      checkUser();
      _scafold.currentState.showSnackBar(SnackBar(
        content: Text('Successfully signed in ${user.uid} '),
      ));
      _timer.cancel();
      Navigator.pushNamed(context, '/signout');
    } catch (e) {
      setState(() {
        //showOtp = false;
      });
      _scafold.currentState.showSnackBar(SnackBar(
        content: Text("Wrong Otp please check ${e} "),
      ));
    }
  }
}

class foregroundBack extends StatelessWidget {
  const foregroundBack({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height - (size.height / 3) + 20,
      width: size.width - 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: kForeground.withOpacity(0.5),
      ),
    );
  }
}

class TopCon extends StatelessWidget {
  const TopCon({
    Key key,
    @required this.size,
  }) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: kpadding * 8, right: kpadding * 8),
        alignment: Alignment.center,
        width: size.width,
        height: size.height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME TO $appName',
              style: TextStyle(
                  color: kForeground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                        color: kBorder.withOpacity(0.5),
                        offset: Offset(0, 6),
                        spreadRadius: 12,
                        blurRadius: 12)
                  ]),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '“If more of us valued food and cheer and song above hoarded gold, it would be a merrier world.” ...',
              style: TextStyle(color: kForeground, fontSize: 17, shadows: [
                BoxShadow(
                    color: kBorder.withOpacity(0.5),
                    offset: Offset(0, 6),
                    spreadRadius: 12,
                    blurRadius: 12)
              ]),
            )
          ],
        ));
  }
}

class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: FlatButton(
                child: Text('SignOut'),
                onPressed: () async {
                  _auth.signOut();
                  Navigator.pop(context);
                },
              ),
              width: 60,
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
