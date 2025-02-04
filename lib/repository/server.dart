import 'package:dio/dio.dart';
import '../model/entity.dart';
import 'package:logger/logger.dart';

// change here
const String baseUrl = 'http://10.0.2.2:2528';

class ServerRepository {
  static final ServerRepository instance = ServerRepository._init();
  static final Dio dio = Dio();
  var logger = Logger();

  ServerRepository._init();



}