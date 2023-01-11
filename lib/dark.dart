import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dark extends StatelessWidget {
  const Dark({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black,
      // systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarDividerColor: Colors.transparent,
    ));
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: const Center(
          child: Text(
            'Flutter Demo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ));
  }
}
