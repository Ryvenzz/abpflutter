import 'package:flutter/material.dart';
import 'package:abp/item/catalog.dart';
import 'package:abp/API/api_service.dart';

class StoreCatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic argument = ModalRoute.of(context)!.settings.arguments;
    final int storeId = argument is int ? argument : int.parse(argument.toString());

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(134, 28, 30, 1),
          ),
        ),
      ),
      body: FutureBuilder<List<catalog>>(
        future: ApiService.fetchCatalog(storeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          }

          final catalogs = snapshot.data!;
          final storeName = catalogs.isNotEmpty ? catalogs.first.shopNamaToko : 'Store';

          return Column(
            children: [
              AppBar(
                title: Text(
                  storeName,
                  style: TextStyle(color: Colors.white),
                ),
                automaticallyImplyLeading: false,
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: catalogs.length,
                  itemBuilder: (context, index) {
                    final catalogItem = catalogs[index];
                    return GestureDetector(
                      onTap: () {
                        _showModal(context);
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
                                  image: DecorationImage(
                                    image: NetworkImage(catalogItem.imageMenu ?? 'placeholder_image_url'),
                                    fit: BoxFit.cover,
                                  ),
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
                                        child: Text('${catalogItem.hargaMenu}'),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          _showModal(context);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    catalogItem.namaMenu,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    catalogItem.deskripsiMenu,
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
              ),
            ],
          );
        },
      ),
    );
  }

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
              Text('Order Product'),
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
                  print('Ordered $quantity products');
                  Navigator.pop(context);
                },
                child: Text('Order'),
              ),
            ],
          ),
        );
      },
    );
  }
}
