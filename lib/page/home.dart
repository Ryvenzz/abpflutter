import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../API/api_service.dart';
import '../item/Product.dart';

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
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(134, 28, 30, 1),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.store),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/store');
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_basket),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/store');
            },
          ),
          IconButton(
            icon: Icon(Icons.login),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
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

  Widget _buildBestSelling() {
  return FutureBuilder<List<Product>>(
    future: ApiService.fetchProduct(),
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return _buildProductCard(context, product);
              },
            ),
          ],
        );
      }
    },
  );
}

Widget _buildProductCard(BuildContext context, Product product) {
  return GestureDetector(
    onTap: () {
      // Add your onTap logic here
    },
    child: Container(
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
              // You can display product image here
              // Example: Image.network(product.imageMenu),
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
                      child: Text('Price: \$${product.hargaMenu}'),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _showModal(context, product);
                        // Add your add to cart logic here
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
                  product.deskripsiMenu,
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
    ),
  );
}

  void _showModal(BuildContext context, Product product) {
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
                  print('Ordered $quantity of ${product.namaMenu}');
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

  
}
