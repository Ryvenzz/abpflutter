import 'package:flutter/material.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/registration.dart';
import 'page/catalogpage.dart';
import 'page/shop_page.dart';
import 'page/cartpage.dart';
import 'page/bookingpage.dart';
import 'page/menubookingpage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Telyu Canteen",
    initialRoute: '/login',
    routes: {
      '/home': (context) => HomePage(),
      '/login': (context) => LoginPage(),
      '/registration': (context) => RegistrationPage(),
      '/store': (context) => ShopPage(),
      // '/catalog': (context) => CatalogPage(),
      '/cart': (context) => CartPage(),
      '/invoice': (context) => PageBooking(),
      // '/menuinvoice': (context) => MenuBookingPage(),

    },
    
  ));
}
