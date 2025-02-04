import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../repository/local_db_repo.dart';
import '../repository/network.dart';
import '../repository/server.dart';

class DataService extends ChangeNotifier {
  final DatabaseRepository _dbRepo;
  final ServerRepository _serverRepo;
  final NetworkConnectivity _connectivity;
  bool online = false;
  static Logger logger = Logger();
  Map _source = {ConnectivityResult.none: false};
  String string = '';

  static Future<DataService> init() async {
    return DataService(DatabaseRepository(), ServerRepository.instance, NetworkConnectivity.instance);
  }

  DataService(this._dbRepo, this._serverRepo, this._connectivity) {
    connection();
  }

  void connection() {
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      _source = source;
      var newStatus = true;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string = _source.values.toList()[0] ? 'Mobile: online' : 'Mobile: offline';
          break;
        case ConnectivityResult.wifi:
          string = _source.values.toList()[0] ? 'Wifi: online' : 'Wifi: offline';
          newStatus = _source.values.toList()[0] ? true : false;
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
          newStatus = false;
      }
      if (online != newStatus) {
        online = newStatus;
      }
    });
  }

  // IMPLEMENT REST OF THE METHODS HERE
}

