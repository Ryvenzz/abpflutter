import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Telyu Canteen',
          style: TextStyle(
            color: Colors.white
          )
          ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(134, 28, 30, 1)
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.store),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/store');
            } ,
          ),
          IconButton(
            icon: Icon(Icons.shopping_basket),
            color: Colors.white,
            onPressed: (){
              Navigator.pushNamed(context, '/store');
            },
          ),
          IconButton(
            icon: Icon(Icons.login),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // _buildSearchBar(),
            // SizedBox(height: 20),
            // _buildStores(context),
            // SizedBox(height: 20),
            _buildBestSelling(),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Widget _buildSearchBar() {
  //   return TextField(
  //     decoration: InputDecoration(
  //       hintText: 'Search here...',
  //       prefixIcon: Icon(Icons.search),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildStores(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Toko',
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(height: 10),
  //       SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           children: List.generate(10, (index) {
  //             return GestureDetector(
  //               onTap: () {
  //                 Navigator.pushNamed(
  //                   context,
  //                   '/store',
  //                   arguments: 'toko ${index + 1}',
  //                 );
  //               },
  //               child: Container(
  //                 margin: EdgeInsets.only(right: 10),
  //                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[200],
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Text('Toko ${index + 1}'),
  //               ),
  //             );
  //           }),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildBestSelling() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Menu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildProductCard(context);
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
          ),
        ),
        Padding(
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
                    child: Text('Price'), // Placeholder for product price
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showModal(context); // Panggil fungsi modal saat tombol "Add" ditekan
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Product Title',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Write description of product',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ],
    ),
  );
}

// Fungsi untuk menampilkan bottom modal sheet
void _showModal(BuildContext context) {
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
            Text('Order Product'), // Modal title
            SizedBox(height: 20),
            TextFormField(
              initialValue: '1',
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
              onPressed: () {
                // Logic to order product goes here
                print('Ordered $quantity products');
                Navigator.pop(context); // Close modal
              },
              child: Text('Order'), // Order button
            ),
          ],
        ),
      );
    },
  );
}


  
  
  Widget _buildBottomNavigationBar() {
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
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Color.fromARGB(255, 250, 248, 248).withOpacity(0.8),
      unselectedItemColor: Colors.grey,
      backgroundColor: const Color.fromRGBO(134, 28, 30, 1),
    );
  }
}

// 