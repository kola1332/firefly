// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firefly/ten.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  print('r START');
  print('t5 $initialLink');
  print('t6 ${initialLink?.android}');
  print('t7 ${initialLink?.link}');

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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
    testLink();
    testLink2();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
    ));
    return MaterialApp(
      routes: {
        '/profi': ((context) => const Profile()),
        "/start": ((context) => const Profile()),
        // '/': ((context) => const Profile()),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
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
}

void testLink2() async {
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("firefly.page.link"),
    uriPrefix: "https://example.page.link",
    androidParameters:
        const AndroidParameters(packageName: "com.example.firefly"),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
}

void testLink3() async {
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("firefly.page.link"),
    uriPrefix: "https://example.page.link",
    androidParameters:
        const AndroidParameters(packageName: "com.example.firefly"),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
}

void testLink4() async {
  final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("firefly.page.link"),
    uriPrefix: "https://example.page.link",
    androidParameters:
        const AndroidParameters(packageName: "com.example.firefly"),
  );
  final dynamicLink =
      await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
}
