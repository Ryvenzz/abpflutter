import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../API/api_service.dart';
import '../item/menubooking.dart';

class MenuBookingPage extends StatefulWidget {
  final int invoiceId;

  MenuBookingPage({required this.invoiceId});

  @override
  _MenuBookingPageState createState() => _MenuBookingPageState();
}

class _MenuBookingPageState extends State<MenuBookingPage> {
  late Future<List<MenuBooking>> _futureMenuBooking;

  @override
  void initState() {
    super.initState();
    _futureMenuBooking = ApiService.showMenuBooking(widget.invoiceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Booking',
        style: TextStyle(color: Colors.white)
        ),
        backgroundColor: const Color.fromRGBO(134, 28, 30, 1),
      ),
      body: FutureBuilder<List<MenuBooking>>(
        future: _futureMenuBooking,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) { // Tambahkan pengecekan untuk snapshot.data
            List<MenuBooking> menuBookings = snapshot.data!;
            return ListView.builder(
              itemCount: menuBookings.length,
              itemBuilder: (context, index) {
                MenuBooking menuBooking = menuBookings[index];
                return ListTile(
                  title: Text(menuBooking.namaMenu),
                  subtitle: Text('Quantity: ${menuBooking.quantity}'),
                  trailing: Text('Harga: ${menuBooking.hargaMenu}'),
                );
              },
            );
          } else {
            return Center(child: Text('No data available')); // Tampilkan pesan jika tidak ada data
          }
        },
      ),
    );

  }
}
