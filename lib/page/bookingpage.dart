import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../API/api_service.dart';
import '../item/booking.dart';
import '../page/menubookingpage.dart';



class PageBooking extends StatefulWidget {
  @override
  _PageBookingState createState() => _PageBookingState();
}

class _PageBookingState extends State<PageBooking> {
  late Future<List<Booking>> _futureBooking;

  @override
  void initState() {
    super.initState();
    _futureBooking = _loadBookingHistory();
  }

  Future<List<Booking>> _loadBookingHistory() async {
    try {
      return ApiService.showInvoice();
    } catch (e) {
      throw Exception('Failed to load booking history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History',
        style: TextStyle(color: Colors.white)
        ),
        backgroundColor: const Color.fromRGBO(134, 28, 30, 1),
      ),
      body: FutureBuilder<List<Booking>>(
        future: _futureBooking,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No booking history available'));
          } else {
            List<Booking> bookings = snapshot.data!;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                Booking booking = bookings[index];
                return ListTile(
                  title: Text('Booking ID: ${booking.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Harga: ${booking.totalHarga}'),
                      Text('Status Pesanan: ${booking.statusLengkap == "Belum Lengkap" ? "Dalam proses" : booking.statusLengkap}'),
                    ],
                  ),
                  trailing: TextButton(
                    onPressed: () async {
  // Pastikan bahwa Anda memiliki invoiceId yang sesuai dari objek booking
                        int invoiceId = booking.id; // Ubah ini sesuai dengan sumber invoiceId yang benar

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuBookingPage(invoiceId: invoiceId),
                          ),
                        );
                      },
                    child: Text(
                      'Lihat Pesanan',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}

Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromRGBO(134, 28, 30, 1),
      selectedItemColor: Color.fromARGB(255, 250, 248, 248).withOpacity(0.8),
      unselectedItemColor: Colors.grey,
      currentIndex: 3,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
      
      
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(
              context, '/home'
            );
            return;
          case 1:
            Navigator.pushNamed(
              context, '/store'
            );
            return;
          case 2:
            Navigator.pushNamed(
              context, '/cart'
            );
            return;
          case 3:
            Navigator.pushNamed(
              context, '/invoice'
            );
            return;
        }
      },
    );
  }