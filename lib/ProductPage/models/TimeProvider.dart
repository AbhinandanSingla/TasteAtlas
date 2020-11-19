import 'dart:async';

import 'package:flutter/cupertino.dart';

class OtpTimerProvider extends ChangeNotifier {
  var OtpTime = 120;
  bool Lock = false;

  Timer OtpTimer;

  void timer() async {
    if (OtpTimer != null) {
      OtpTimer.cancel();
    }

    OtpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (OtpTime > 0) {
        Lock = true;
        OtpTime--;
      } else {
        Lock = false;
        OtpTimer.cancel();
        OtpTime = 120;
      }
      notifyListeners();
    });
  }
}
