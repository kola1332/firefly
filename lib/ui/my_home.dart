// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api testiing'),
      ),
      body: Container(
        child: const Center(
          child: Text('API TESTING'),
        ),
      ),
    );
  }
}
