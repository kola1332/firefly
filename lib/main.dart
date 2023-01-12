// ignore_for_file: avoid_print

import 'package:firefly/tex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firefly/dark.dart';
import 'package:firefly/ten.dart';
import 'firebase_options.dart';

// ?? | push
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  print('===============================================================');
  print('');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  print('r start >>>>>>>>>>');
  print('[initialLink] $initialLink');
  print('[initialLink?.link] ${initialLink?.link}');
  final Uri? uri = initialLink?.link;
  if (uri != null) {
    final queryParams = uri.queryParameters;
    print('() ${uri.queryParameters}');
    if (queryParams.isNotEmpty) {
      // Navigator.of(context).pushNamed(queryParams.values.first);
      print('() ${queryParams.values.first}');
    }
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // FirebaseMessaging.instance.onTokenRefresh
  //     .listen((fcmToken) {})
  //     .onError((err) {});
  // print('token: $fcmToken');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => Work();
}

class Work extends State<MyApp> {
  @override
  void initState() {
    //////////////////////////////////////////////////////////////////////////
    super.initState();
    initDynamicLinks();
    // Future<String> route = rideLightning();
    // print('[route] $route');
    initDynamicLinks2();
  }

  @override
  Widget build(BuildContext context) {
    // try work dyn | early | **
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      print('** ${dynamicLinkData.link.path}');
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('** error!!');
      throw Exception();
    });

    // try work dyn | from G | &&
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      print('&& ${dynamicLinkData.link}');
      final queryParams = uri.queryParameters;
      print('&& ${uri.queryParameters}');
      if (queryParams.isNotEmpty) {
        Navigator.of(context).pushNamed(queryParams.values.first);
        print('&& ${queryParams.values.first}');
      }
    });

    // ThemeCode
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
    ));
    return MaterialApp(
      routes: {
        // '/': ((context) => const Dark()),
        '/': ((context) => Tex(m: '/')),
        // '/profi': ((context) => const Profile()),
        // '/start': ((context) => const Profile()),
        // '/dark': ((context) => const Dark()),
        // '/light': ((context) => const Home()),
        '/profi': ((context) => Tex(m: 'profi')),
        '/start': ((context) => Tex(m: 'start')),
        '/dark': ((context) => Tex(m: 'dark')),
        '/light': ((context) => Tex(m: 'light')),
        '/text': ((context) => Tex(m: 'text')),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      // home: (route1 == 'https://www.google.com') ? const Dark() : const Home(),
    );
  }

  //try work dyn | from G | ()
  void initDynamicLinks2() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        Navigator.of(context).pushNamed(queryParams.values.first);
        print('() ${queryParams.values.first}');
      }
    });
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

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
            'Flutter Demo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }
}

void initDynamicLinks() async {
  // print('t start >>>>>>>>>>'); //
  var t = FirebaseDynamicLinks.instance.onLink;
  final PendingDynamicLinkData? initialLinkk =
      await FirebaseDynamicLinks.instance.getInitialLink();
  // print('t1 ${t.length}');
  // print('t2 $t');
  // print('t3 ${t.isEmpty}');
  // print('t4 ${t.isEmpty}');
  // print('[initialLinkk] $initialLinkk'); //
  // print('[initialLinkk?.android] ${initialLinkk?.android}'); //
  // print('[initialLinkk?.link] ${initialLinkk?.link}'); //

  // FirebaseDynamicLinks.instance.onLink(
  //     onSuccess: (PendingDynamicLinkData? dynamicLink) async {
  //   final Uri? deeplink = dynamicLink?.link;

  //   if (deeplink != null) {
  //     print('deeplink data $deeplink');
  //   }
  // }, onError: (OnLinkErrorException e) async {
  //   print(e);
  // });
}

class OnLinkErrorException {}

// try work dyn | harder
Future<String> rideLightning() async {
  final PendingDynamicLinkData? link =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (link?.link != null) {
    // ignore: unrelated_type_equality_checks
    if (link!.link == 'https://www.google.com') {
      print('home');
      return 'home';
    } else {
      return '/';
    }
  } else {
    return '/';
  }
}
