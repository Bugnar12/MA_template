import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../model/entity.dart' as entity;

class DatabaseRepository {
  static const int _version = 1;
  // change here
  static const String _name = 'app4.db';
  static Logger logger = Logger();



}