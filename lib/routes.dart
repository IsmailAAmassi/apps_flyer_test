import 'package:apps_flyer_test/pages/home_page.dart';
import 'package:apps_flyer_test/pages/second_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (context) => const HomePage(),
  '/second': (context) => const SecondPage(),
};
