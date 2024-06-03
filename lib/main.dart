import 'package:flutter/material.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/registration.dart';
import 'page/catalogpage.dart';
import 'page/shop_page.dart';
import 'page/cartpage.dart';
import 'page/bookingpage.dart';
import 'page/menubookingpage.dart';
import 'page/loadingpage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Telyu Canteen",
    // initialRoute: '/login',
    home: ImagePage(),
    routes: {
      '/home': (context) => HomePage(),
      '/login': (context) => LoginPage(),
      '/registration': (context) => RegistrationPage(),
      '/store': (context) => ShopPage(),
      // '/catalog': (context) => CatalogPage(),
      '/cart': (context) => CartPage(),
      '/invoice': (context) => PageBooking(),
      // '/menuinvoice': (context) => MenuBookingPage(),
      '/loading': (context) => loadingPage()
    },
    
  ));
}

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'aset/uhuy.png', // Gantilah dengan path gambar Anda
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Klik layar untuk login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}