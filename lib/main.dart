import 'package:flutter/material.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/registration.dart';
// import 'page/catalog.dart';
import 'page/shop_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => HomePage(),
      '/login': (context) => LoginForm(),
      '/registration': (context) => RegistrationForm(),
      // '/catalog': (context) => StoreCatalogPage(),
      '/store': (context) => StorePage(),
    },
  ));
}
