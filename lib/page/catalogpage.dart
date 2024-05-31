import 'package:flutter/material.dart';

class StoreCatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String storeName =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$storeName',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(134, 28, 30, 1),
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 10, // Change this to the number of products in the catalog
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showModal(context); // Panggil fungsi modal saat kontainer ditekan
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
            ),
          );
        },
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
}
