import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../repository/network.dart';
import '../widgets/message.dart';

const String wsUrl = 'ws://10.0.2.2:2528';

class Homepage extends StatefulWidget {
  final String title;
  const Homepage(this.title, {super.key});

  @override
  State<StatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final channel = WebSocketChannel.connect(Uri.parse(wsUrl));
  var logger = Logger();
  bool online = true;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _connectivity = NetworkConnectivity.instance;
  String string = '';

  @override
  void initState() {
    super.initState();
    connection();
  }

  void connection() {
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      _source = source;
      logger.log(Level.info, _source);
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
      logger.log(Level.info, "Connection status: $online, $newStatus");
      if (online != newStatus) {
        setState(() {
          online = newStatus;
        });
        if (newStatus) {
          message(context, "Connection restored", "Info");
        } else {
          message(context, "Connection lost", "Info");
        }
      }
    });
  }

  void retryConnection() {
    connection();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}