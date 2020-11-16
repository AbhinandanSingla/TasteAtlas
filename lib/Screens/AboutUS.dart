import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUS extends StatelessWidget {
  _launchBrower(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch';
    }
  }

  _launchPhone(String phoneno) async {
    if (await canLaunch('tel:$phoneno')) {
      await launch(
        'tel:$phoneno',
      );
    } else {
      throw 'Could not launch ';
    }
  }

  _launchSms(String sms) async {
    if (await canLaunch('sms:$sms')) {
      await launch(
        'sms:$sms',
      );
    } else {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      backgroundColor: Color(0xff4B9DB5),
      body: SafeArea(
        child: PageView(
          children: [
            Stack(
              children: [
                Container(
                  width: size.width,
                  child: Image.asset('assets/images/Abhinandan Singla.png'),
                ),
                // Container(
                //   height: size.height,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //         colors: [
                //           Colors.white.withOpacity(0.2),
                //           Colors.black.withOpacity(0.2)
                //         ]),
                //   ),
                // ),
                Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_outlined),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Abhinandan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontFamily: 'Niconne',
                                ),
                              ),
                              Text(
                                'Singla',
                                style: TextStyle(
                                  fontFamily: 'Niconne',
                                  color: Colors.white,
                                  fontSize: 45,
                                ),
                              ),
                              Text(
                                'Ceo of TasteAtlas',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'ltim',
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Patran',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: 'ltim'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  topLeft: Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    spreadRadius: 2,
                                    blurRadius: 0)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'assets/images/line.png',
                              //   scale: 0.9,
                              //   color: Colors.blueGrey,
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Container(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () => _launchBrower(
                                              'https://www.instagram.com/_.abhi_singla_/'),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Color(0xffEDF4FC),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Icon(Icons.person_outline,
                                                color: Color(0xff82A6BC)),
                                          ),
                                        ),
                                        Text('Instagram'),
                                      ],
                                    ),
                                    InkWell(
                                        onTap: () => _launchSms('+9779204835'),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffEDF4FC),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Icon(
                                                Icons.mail_outline,
                                                color: Color(0xff82A6BC),
                                              ),
                                            ),
                                            Text('Message')
                                          ],
                                        )),
                                    InkWell(
                                      onTap: () => _launchPhone('+9779204835'),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Color(0xffEDF4FC),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Icon(
                                              Icons.call,
                                              color: Color(0xff82A6BC),
                                            ),
                                          ),
                                          Text('Call')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: size.width,
                  child: Image.asset('assets/images/deepak.png'),
                ),
                // Container(
                //   height: size.height,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //         colors: [
                //           Colors.white.withOpacity(0.2),
                //           Colors.black.withOpacity(0.2)
                //         ]),
                //   ),
                // ),
                Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_outlined),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deepak',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontFamily: 'Niconne',
                                ),
                              ),
                              Text(
                                'Mittal',
                                style: TextStyle(
                                  fontFamily: 'Niconne',
                                  color: Colors.white,
                                  fontSize: 45,
                                ),
                              ),
                              Text(
                                'Ceo of TasteAtlas',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'ltim',
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Bhawanigarh',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: 'ltim'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  topLeft: Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    spreadRadius: 2,
                                    blurRadius: 0)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   'assets/images/line.png',
                              //   scale: 0.9,
                              //   color: Colors.blueGrey,
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Container(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () => _launchBrower(
                                              'https://www.instagram.com/d_mittal001/'),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Color(0xffEDF4FC),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Icon(Icons.person_outline,
                                                color: Color(0xff82A6BC)),
                                          ),
                                        ),
                                        Text('Instagram'),
                                      ],
                                    ),
                                    InkWell(
                                        onTap: () =>
                                            _launchSms('+919041842831'),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffEDF4FC),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Icon(
                                                Icons.mail_outline,
                                                color: Color(0xff82A6BC),
                                              ),
                                            ),
                                            Text('Message')
                                          ],
                                        )),
                                    InkWell(
                                      onTap: () =>
                                          _launchPhone('+919041842831'),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Color(0xffEDF4FC),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Icon(
                                              Icons.call,
                                              color: Color(0xff82A6BC),
                                            ),
                                          ),
                                          Text('Call')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
