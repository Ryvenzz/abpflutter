import 'package:abp/page/home.dart';
import 'package:abp/page/login.dart';
import 'package:abp/page/registration.dart';
import 'package:abp/page/store.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => HomePage(),
      '/login': (context) => LoginForm(),
      '/registration': (context) => RegistrationForm(),
      '/catalog': (context) => StoreCatalogPage(),
      '/store': (context) => StorePage()
    },
  ));
  
}

