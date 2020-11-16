import 'package:appetizer/ProductPage/models/DrawerScreenProvider.dart';
import 'package:appetizer/Screens/AboutUS.dart';
import 'package:appetizer/Screens/SurveyScreen.dart';
import 'package:appetizer/Screens/cartScreen.dart';
import 'package:appetizer/login/LoginPage.dart';
import 'package:appetizer/login/LoginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'OrderScreen.dart';

class MenuDrawer extends StatelessWidget {
  loginNavigator(BuildContext context) async {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    if (loginProvider.user != null) {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return OrderScreen();
      }));
    } else {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return LoginPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DrawerProvider drawerProvider =
        Provider.of<DrawerProvider>(context, listen: false);
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xff4B9DB5),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Consumer<DrawerProvider>(builder:
                  (BuildContext context, DrawerProvider value, Widget child) {
                return IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    drawerProvider.toggleSwitch();
                  },
                );
              }),
            ],
          ),
          Spacer(
            flex: 2,
          ),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    loginNavigator(context);
                  },
                  child: Image.asset(
                    'assets/images/user.png',
                  )),
              Column(
                children: [
                  Text(
                    'Hii!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Consumer<LoginProvider>(builder: (BuildContext context,
                      LoginProvider value, Widget child) {
                    return Text(
                        value.user != null ? value.name : 'Join kro na yr',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20));
                  }),
                ],
              )
            ],
          ),
          Spacer(
            flex: 3,
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                onTap: () => drawerProvider.toggleSwitch(),
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return CartScreen();
                  }));
                },
                leading: Icon(
                  Icons.backpack_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'My Cart',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white,
                ),
                onTap: () {
                  loginNavigator(context);
                },
                title: Text(
                  'Order History',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer_outlined,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SurveyScreen()));
                },
                title: Text(
                  'Confused ?',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Color(0xffEDF4FC).withOpacity(0.8),
                      content: Text(
                        'This feature is coming soon',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                      )));
                },
                leading: Icon(
                  Icons.star_border,
                  color: Colors.white,
                ),
                title: Text(
                  'Favorites',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return AboutUS();
                  }));
                },
                leading: Icon(
                  Icons.adb_sharp,
                  color: Colors.white,
                ),
                title: Text(
                  'About Us',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onTap: () {
                  loginProvider.signOut();
                },
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Spacer(
            flex: 8,
          ),
        ],
      ),
    );
  }
}
