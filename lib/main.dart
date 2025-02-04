import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/homepage.dart';
import 'service/service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var service = await DataService.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => service,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Exam', // Updated title
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage('Mobile Exam'), // Updated homepage title
    );
  }
}