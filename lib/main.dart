// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firefly/tex.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('NEW LINE ================================');
  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  runApp(MyApp(initialLink: initialLink));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initialLink});
  final initialLink;

  @override
  Widget build(BuildContext context) {
    print(initialLink);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        // '/': (context) => const Home(),
        '/': (context) => Application(initialLink: initialLink),
        '/chat': (context) => const Tex(m: 'Chat'),
        '/home': (context) => const Tex(m: 'Home Page'),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // fcmTokenPrint();
    super.initState();
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

Future<void> fcmTokenPrint() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
}

Future<void> listenNotification(BuildContext context) async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');

    if (message.notification != null) {
      // print('Message also contained a notification: ${message.notification}');
      print('go to chat 1 met');
      Navigator.pushNamed(context, '/chat');
    }
  });
}

Future<void> listenNotification2(BuildContext context) async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage == null) {
    print('no got noti');
  } else {
    print('noti = $initialMessage');
    print('go to chat 2 met');
    Navigator.pushNamed(context, '/chat');
  }
}
