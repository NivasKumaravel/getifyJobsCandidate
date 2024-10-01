import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Login_Screens/Login_Page.dart';
import 'package:getifyjobs/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'Src/utilits/Generic.dart';
import 'Src/utilits/Landing.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//
//   print("Handling a background message: ${message.messageId}");
// }

Future<void> main() async {
  // Ensure Flutter binding is initialized
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // // Initialize Firebase
  // await Firebase.initializeApp();
  //
  // requestNotificationPermission();
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');
  //
  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  //
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print('Message also contained a notification: ${fcmToken}');
  //
  // StoreFCMToken(fcmToken);

  runApp(ProviderScope(child: const MyApp()));
}

// Future<void> requestNotificationPermission() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   print('User granted permission: ${settings.authorizationStatus}');
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Getify Jobs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => Landing(),
        "/login": (context) => Login_Page(),
        "/home": (context) => Bottom_Navigation(select: 0),
        "/candidate": (context) => Candidate_Bottom_Navigation(
            select: 0), //Candidate_Categoery_Screen()
      },
      onGenerateRoute: (value) {
        return MaterialPageRoute(builder: (context) => Login_Page());
      },
      // home: Login_Page(), //Login_Page(),
    );
  }
}
