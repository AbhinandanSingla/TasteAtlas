import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User user;
  bool NumberLength = false;
  bool smsCode = true;
  String message;
  String verificationID;
  String PhoneNo;
  String name;
  bool verified = false;


  phoneLength(value) {
    if (value.length != 10) {
      NumberLength = false;
    } else {
      NumberLength = true;
    }
    notifyListeners();
  }

  smsCodeLength(value) {
    if (value.length != 6) {
      smsCode = false;
    } else {
      smsCode = true;
    }
    notifyListeners();
  }

  void verifyPhoneNumber(String PhoneNumber) async {
   await _auth.signOut();
    PhoneNo = PhoneNumber;
print(PhoneNo);
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      print('PhoneAutomatically verifies');
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) async {
      print('PhoneVerification');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      verificationID = verificationId;
      print('code sent');
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) async {
      verificationID = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + PhoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
          timeout: Duration(minutes: 2));
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signInWithPhoneNumber(String smsCode) async {
    print(smsCode);
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      user = (await _auth.signInWithCredential(credential)).user;
    try {
      await _firestore
          .doc("user/${_auth.currentUser.uid}")
          .get()
          .then((value) {
        name = value.get('firstname');
        if (value.exists) {
          _firestore
              .collection('user')
              .doc(_auth.currentUser.uid)
              .update({"lastLogin": DateTime.now()});
          notifyListeners();
          return verified = true;
        } else {
          notifyListeners();
          return verified = false;
        }
      });
    } catch (e) {
      debugPrint('error in firebase $e');
    }
      print('phone verified ');
      notifyListeners();
  }

  validateUser() {
    if (user == null) {
      print('no user is login ');
    } else {
      print('login is logined');
    }
  }

  addUser(String firstname, String surname, String address) async {
    try {
      await _firestore.collection('user').doc(user.uid).set({
        'uid': user.uid,
        'phonenumber': PhoneNo,
        'firstname': firstname,
        'surname': surname,
        'address': address,
        'lastLogin': DateTime.now(),
        'wishlist': [],
        'lastTransactions': [],
        'totalTransactionsAmount': 0
      });
      name = firstname;
      notifyListeners();
    } catch (e) {}
  }

  void signOut() {
    _auth.signOut();
    user = null;
    verified = false;
    notifyListeners();
  }
}
