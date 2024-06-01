import 'package:flutter/material.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/registration.dart';
import 'page/catalogpage.dart';
import 'page/shop_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => HomePage(),
      '/login': (context) => LoginPage(),
      '/registration': (context) => RegistrationPage(),
      '/store': (context) => ShopPage(),
    },
  ));
}
