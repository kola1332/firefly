// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tex extends StatefulWidget {
  const Tex({super.key, this.m});

  final m;

  @override
  State<Tex> createState() => _TexState();
}

class _TexState extends State<Tex> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
    ));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: Center(
          child: Text(
            widget.m,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              // color: Colors.white,
            ),
          ),
        ));
  }
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("Handling a background message231: ${message.messageId}");
    Navigator.pushNamed(context, '/chat');
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(context, '/chat');
    }
  }

  void deepLinkPush(initialLink) {
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen
      print(deepLink.path);
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: const Center(
          child: Text(
        'Home',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      )),
    );
  }
}
