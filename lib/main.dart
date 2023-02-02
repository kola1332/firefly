// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:firefly/network/model/api_service.dart';
import 'package:firefly/ui/my_home.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
      (rec) => {print("${rec.level.name}: ${rec.time} : ${rec.message}")});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ApiService.create(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
        ),
        home: const MyHome(),
      ),
    );
  }
}
