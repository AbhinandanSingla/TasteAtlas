import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';

enum ConnectionResult { Working, Offline }

class CheckConnectionStatus {
  StreamController<ConnectionResult> connectionChecker =
      StreamController<ConnectionResult>();

  CheckConnectionStatus() {
    DataConnectionChecker().onStatusChange.listen((status) {
      var ConnectionStatus = _check(status);
      connectionChecker.add(ConnectionStatus);
    });
  }

  ConnectionResult _check(DataConnectionStatus _status) {
    switch (_status) {
      case DataConnectionStatus.disconnected:
        return ConnectionResult.Offline;
      case DataConnectionStatus.connected:
        return ConnectionResult.Working;
      default:
        return ConnectionResult.Offline;
    }
  }
}
