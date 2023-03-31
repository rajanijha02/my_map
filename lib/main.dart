import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_map/bindings.dart';
import 'package:my_map/gmap/view/gmap_view.dart';
import 'package:my_map/history/view/history_view.dart';
import 'package:my_map/home/view/home_view.dart';
import 'package:my_map/login/view/login_view.dart';
import 'package:my_map/maphistory/view/maphistory_view.dart';
import 'package:my_map/register/view/register_view.dart';
import 'package:my_map/splash/views/splash_views.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/**
 * -> Native Android Code 
 * 
 * -> Cross Platform App Code
 * 
 * 
 * 
 * 
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // --> Initialize Firebase app
  String? token = await FirebaseMessaging.instance.getToken();

  print(token);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((event) {
    RemoteNotification? data = event.notification;
    if (data != null) {
      flutterLocalNotificationsPlugin.show(
        1,
        data.title,
        data.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            icon: '@mipmap/ic_launcher',
            color: Colors.blue,
            ledColor: Colors.blue,
            ledOnMs: 1000,
            ledOffMs: 500,
          ),
        ),
      );
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    RemoteNotification? data = event.notification;
print(data!.title);
    print(data.body);
    if (data != null) {
      flutterLocalNotificationsPlugin.show(
        1,
        data.title,
        data.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            icon: '@mipmap/ic_launcher',
            color: Colors.blue,
            ledColor: Colors.blue,
            ledOnMs: 1000,
            ledOffMs: 500,
          ),
        ),
      );
    }
  });
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyMaps());
}

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyMaps extends StatelessWidget {
  const MyMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Map',
      debugShowCheckedModeBanner: false,
      initialBinding: StorageBindings(),
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomeView(),
          binding: HomeBindings(),
        ),
        GetPage(
          name: '/splash',
          page: () => const SplashViews(),
          binding: SplashBindings(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginView(),
          binding: LoginBindings(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterView(),
          binding: RegisterBindings(),
        ),
        GetPage(
          name: '/history',
          page: () => const HistoryView(),
          binding: HistoryBindings(),
        ),
        GetPage(
          name: '/maphistory',
          page: () => const MapHistoryView(),
          binding: MapHistoryBindings(),
        ),
        GetPage(
          name: '/gmap',
          page: () => const GMapView(),
          binding: GMapBindings(),
        ),
      ],
      initialRoute: '/splash',
    );
  }
}
