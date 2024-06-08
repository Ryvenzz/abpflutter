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
import '../API/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Telyu Canteen",
      home: ImagePage(),
      routes: {
      '/home': (context) => HomePage(),
      // '/main': (context)=> MainLayout(),
      '/login': (context) => LoginPage(),
      '/registration': (context) => RegistrationPage(),
      '/store': (context) => ShopPage(),
      // '/catalog': (context) => CatalogPage(),
      '/cart': (context) => CartPage(),
      '/invoice': (context) => PageBooking(),
      // '/menuinvoice': (context) => MenuBookingPage(),
      '/loading': (context) => loadingPage()
    },
    );
  }
}

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'aset/uhuy.png',
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

// class MainLayout extends StatefulWidget {
//   @override
//   _MainLayoutState createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   int _currentIndex = 0;

//   final List<Widget> _children = [
//     HomePage(),
//     ShopPage(),
//     CartPage(),
//     PageBooking(),
//   ];

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _children,
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(context),
//     );
//   }

//   Widget _buildBottomNavigationBar(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: const Color.fromRGBO(134, 28, 30, 1),
//       selectedItemColor: Color.fromARGB(255, 250, 248, 248).withOpacity(0.8),
//       unselectedItemColor: Colors.grey,
//       currentIndex: _currentIndex,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.store),
//           label: 'Store',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_basket),
//           label: 'Cart',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.history),
//           label: 'History',
//         ),
//       ],
//       onTap: onTabTapped,
//     );
//   }
// }