import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../API/api_service.dart';
import '../item/menucart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _bookingId = 0;
  List<MenuCart> _menuCartList = [];

  @override
  void initState() {
    super.initState();
    _getBookingId();
  }

  void _getBookingId() async {
    try {
      int? bookingId = await ApiService.getBookingIdByUser();
      setState(() {
        _bookingId = bookingId ?? 0;
      });
      _showCart();
    } catch (e) {
      print('Failed to get booking ID: $e');
    }
  }

  void _showCart() async {
    try {
      Map<String, dynamic> cartData = await ApiService.showCart(_bookingId);
      setState(() {
        _menuCartList = List<MenuCart>.from(
          cartData['data']['Checkout'].map(
            (item) => MenuCart.fromJson(item),
          ),
        );
      });
    } catch (e) {
      print('Failed to show cart: $e');
    }
  }

  void _editCart(MenuCart menuCart, int newQuantity) async {
  // Implementasi fungsi edit cart di sini
    try {
      await ApiService.editCart(
        _bookingId,
        menuCart.id,
        newQuantity, // Menggunakan nilai baru jumlah produk
      );
      // Refresh cart setelah berhasil edit
      _showCart();
    } catch (e) {
      print('Failed to edit cart: $e');
      // Handle error
    }
  }

  void _deleteCart(MenuCart menuCart) async {
    // Implementasi fungsi delete cart di sini
    try {
      await ApiService.deleteCart(
        _bookingId,
        menuCart.id,
      );
      // Refresh cart setelah berhasil delete
      _showCart();
    } catch (e) {
      print('Failed to delete cart: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
  flexibleSpace: Container(
    decoration: BoxDecoration(
      color: const Color.fromRGBO(134, 28, 30, 1),
    ),
  ),
  actions: [
      IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
            onPressed: () async {
              // Tampilkan dialog konfirmasi
              bool confirm = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Checkout'),
                    content: Text('Are you sure you want to proceed with the checkout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // Tutup dialog dengan nilai false
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true); // Tutup dialog dengan nilai true
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  );
                },
              );

              // Jika pengguna menekan tombol "Checkout" pada dialog konfirmasi
              if (confirm == true) {
                // Lakukan checkout
                try {
                  await ApiService.checkout(_bookingId, 'QRIS');
                  // Tampilkan snackbar bahwa checkout berhasil
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Checkout successful'),
                      
                    ),
                  );
                  Navigator.pushNamed(context, '/home');
                } catch (error) {
                  // Tangani kesalahan saat checkout
                  print('Failed to checkout: $error');
                  // Tampilkan snackbar bahwa terjadi kesalahan saat checkout
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to checkout: $error'),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),

      body: _bookingId == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _menuCartList.isEmpty
              ? Center(
                  child: Text('Your cart is empty'),
                )
              : ListView.builder(
                  itemCount: _menuCartList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(_menuCartList[index].namaMenu),
                        subtitle: Text('Quantity: ${_menuCartList[index].quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _showEditQuantityDialog(_menuCartList[index]),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteCart(_menuCartList[index]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  void _showEditQuantityDialog(MenuCart menuCart) {
    int newQuantity = menuCart.quantity; // Default quantity diisi dengan jumlah saat ini
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Quantity'),
          content: TextFormField(
            initialValue: menuCart.quantity.toString(), // Menampilkan jumlah saat ini di dalam field input
            keyboardType: TextInputType.number,
            onChanged: (value) {
              newQuantity = int.tryParse(value) ?? menuCart.quantity; // Mengubah nilai quantity baru ketika ada perubahan pada input
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog tanpa menyimpan perubahan
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Panggil fungsi untuk mengedit keranjang dengan jumlah baru
                _editCart(menuCart, newQuantity);
                Navigator.of(context).pop(); // Tutup dialog setelah berhasil menyimpan perubahan
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
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
      ],
      selectedItemColor: Color.fromARGB(255, 250, 248, 248).withOpacity(0.8),
      unselectedItemColor: Colors.grey,
      backgroundColor: const Color.fromRGBO(134, 28, 30, 1),
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
        }
      },
    );
  }
}