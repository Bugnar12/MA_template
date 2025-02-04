import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

/// Singleton class for monitoring network connectivity status
class NetworkConnectivity {
  NetworkConnectivity._();
  // singleton
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  // connectivity monitoring
  final _networkConnectivity = Connectivity();
  // allow multiple clients to react to connectivity changes and broadcasts changes
  // TODO: read more about StreamController
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream.asBroadcastStream();
  static Logger logger = Logger();

  // init network listener
  void initialize() async {
    List<ConnectivityResult> results = await _networkConnectivity.checkConnectivity();
    for (var result in results) {
      _checkStatus(result);
    }
    _networkConnectivity.onConnectivityChanged.listen((results) {
      for (var result in results) {
        logger.log(Level.info, "Network initialize() result: $result");
        _checkStatus(result);
      }
    });
  }

  // checks internet connectivity by trying to resolve google.com
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final lookupResult = await InternetAddress.lookup('google.com');
      isOnline = lookupResult.isNotEmpty && lookupResult[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}