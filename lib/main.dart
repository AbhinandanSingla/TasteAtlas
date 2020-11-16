import 'package:appetizer/ProductPage/models/FeatureProvider.dart';
import 'package:appetizer/ProductPage/models/MainScreenProviders.dart';
import 'package:appetizer/ProductPage/models/OrderScreenProvider.dart';
import 'package:appetizer/ProductPage/models/connectionChecker.dart';
import 'package:appetizer/Screens/MainFrontScreen.dart';
import 'package:appetizer/login/OtpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProductPage/models/DrawerScreenProvider.dart';
import 'ProductPage/models/SurveyProvider.dart';
import 'ProductPage/models/TimeProvider.dart';
import 'ProductPage/models/cartProvider.dart';
import 'Screens/MainScreen.dart';
import 'login/AddUser.dart';
import 'login/LoginPage.dart';
import 'login/LoginProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MainScreenProvider>(
              create: (context) => MainScreenProvider()),
          ChangeNotifierProvider<FeatureProvider>(
              create: (context) => FeatureProvider()),
          ChangeNotifierProvider<CartProvider>(
              create: (context) => CartProvider()),
          ChangeNotifierProvider<DrawerProvider>(
              create: (context) => DrawerProvider()),
          ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider()),
          ChangeNotifierProvider<SurveyProvider>(
              create: (context) => SurveyProvider()),
          ChangeNotifierProvider<OtpTimerProvider>(
              create: (context) => OtpTimerProvider()),
          ChangeNotifierProvider<OrderScreenProvider>(
              create: (context) => OrderScreenProvider()),
          StreamProvider<ConnectionResult>.value(
              value: CheckConnectionStatus().connectionChecker.stream),
        ],
        child: MaterialApp(
            home: MainScreen(),
            routes: {
              '/home': (context) => MainScreen(),
              '/mainScreen': (context) => MainFrontScreen(),
              '/login': (context) => LoginPage(),
              '/otp': (context) => OtpPage(),
              '/adduser': (context) => Adduser()
            },
            debugShowCheckedModeBanner: false));
  }
}
