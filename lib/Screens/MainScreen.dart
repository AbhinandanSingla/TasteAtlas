import 'package:appetizer/ProductPage/models/connectionChecker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'MainDrawerScreen.dart';
import 'MainFrontScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool ConnectionCheck = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MenuDrawer(),
            MainFrontScreen(),
            Consumer<ConnectionResult>(
              builder:
                  (BuildContext context, ConnectionResult value, Widget child) {
                switch (value) {
                  case ConnectionResult.Working:
                    ConnectionCheck = false;
                    break;
                  case ConnectionResult.Offline:
                    ConnectionCheck = true;
                    break;
                  default:  
                    ConnectionCheck = false;
                }
                return Visibility(
                  visible: ConnectionCheck,
                  child: Container(width: size.width,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                              'assets/images/Lotties/12955-no-internet-connection-empty-state.json',
                              width: size.width * 0.8),
                          Text('Waiting for Connection...')
                        ],
                      )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
