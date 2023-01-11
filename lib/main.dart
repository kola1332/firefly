// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firefly/dark.dart';
import 'package:firefly/ten.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
  print('r START');
  print('t5 $initialLink');
  print('t8 ${initialLink?.link}');

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  final fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });
  print('token: $fcmToken');

  runApp(MyApp(initialLink));
}

class MyApp extends StatefulWidget {
  MyApp(PendingDynamicLinkData? initialLink, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    testLink();
    testLink2();
    Future<String> route = rideLightning();
    print('rr $route');
    print('rr');
  }

  @override
  Widget build(BuildContext context) {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      throw Exception();
    });
    Future<String> route = rideLightning();
    print('rr $route');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
    ));
    return MaterialApp(
      routes: {
        '/': ((context) => const Dark()),
        '/profi': ((context) => const Profile()),
        "/start": ((context) => const Profile()),
        "/dark": ((context) => const Dark()),
        "/light": ((context) => const Home()),
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
  print('t start');
  var t = FirebaseDynamicLinks.instance.onLink;
  final PendingDynamicLinkData? initialLinkk =
      await FirebaseDynamicLinks.instance.getInitialLink();
  // print('t1 ${t.length}');
  // print('t2 $t');
  // print('t3 ${t.isEmpty}');
  // print('t4 ${t.isEmpty}');
  print('t5 $initialLinkk');
  print('t6 ${initialLinkk?.android}');
  print('t7 ${initialLinkk?.link}');

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

void testLink() async {
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("https://www.example.com/"),
    uriPrefix: "https://example.page.link",
    androidParameters:
        const AndroidParameters(packageName: "com.example.firefly"),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
  print('dynamic $dynamicLink');
}

void testLink2() async {
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("https://firefly.page.link/start"),
    uriPrefix: "https://firefly.page.link/",
    androidParameters:
        const AndroidParameters(packageName: "com.example.firefly"),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
  print('dynamic $dynamicLink');
}

Future<String> rideLightning() async {
  final PendingDynamicLinkData? link =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (link?.link != null) {
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
