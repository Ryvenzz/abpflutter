import 'package:flutter/material.dart';
import '../item/menushop.dart';
import '../API/api_service.dart';

class CatalogPage extends StatelessWidget {
  final int shopId;

  CatalogPage({required this.shopId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog Toko $shopId',
        style: TextStyle(color: Colors.white),),
         backgroundColor: const Color.fromRGBO(134, 28, 30, 1),
      ),
      body: FutureBuilder<List<Menu>>(
        future: ApiService.fetchMenuByShop(shopId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                GridView.builder(
                  padding: EdgeInsets.all(16.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Menu Menus = snapshot.data![index];
                    return _buildProductCard(context, Menus);
                  },
                ),
              ]
            );
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildProductCard(BuildContext context, Menu product) {
  return GestureDetector(
    onTap: () {
      // Add your onTap logic here
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          // Background image
          Container(
            height: 400.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  product.imageMenu != null
                      ? 'http://10.0.2.2:8001/api/${product.imageMenu}'
                      : 'https://fivestar.sirv.com/example.jpg?profile=Example',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Text and other content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 236, 19, 4).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('\Rp.${product.hargaMenu}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          try {
                            int? bookingId = await ApiService.getBookingIdByUser();
                            if (bookingId == null) {
                              // Handle the case where the booking ID is not found
                              throw Exception('Booking ID not found');
                            }
                            _showModal(context, product, bookingId);
                          } catch (e) {
                            // Handle any errors that occur
                            print('Error: $e');
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.namaMenu,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Stok: "+product.stokMenu.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.deskripsiMenu,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  void _showModal(BuildContext context, Menu product, int bookingId) {
    int quantity = 1;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Order ${product.namaMenu}'), // Modal title
              SizedBox(height: 20),
              TextFormField(
                initialValue: '1', // Menggunakan '1' sebagai nilai awal
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 1;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ApiService.addCart(bookingId, product.id, quantity);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to cart')));
                    Navigator.pop(context); // Close modal
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add to cart: $e')));
                  }
                },
                child: Text('Order'), // Order button
              ),
            ],
          ),
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
