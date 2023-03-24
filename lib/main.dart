import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_map/bindings.dart';
import 'package:my_map/home/view/home_view.dart';
import 'package:my_map/splash/views/splash_views.dart';

void main() {
  runApp(const MyMaps());
}


class MyMaps extends StatelessWidget {
  const MyMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Map',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/home', page: () => HomeView(), binding: HomeBindings(),),
        GetPage(name: '/splash', page: () => SplashViews(), binding: SplashBindings(),),
      ],
      initialRoute: '/splash',
    );
  }
}