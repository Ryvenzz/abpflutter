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
        title: Text('Catalog Toko $shopId'),
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Menu Menus = snapshot.data![index];
                return ListTile(
                  title: Text(Menus.namaMenu),
                  subtitle: Text('Price: ${Menus.hargaMenu}'),
                  // Tambahkan detail menu lainnya sesuai kebutuhan
                );
              },
            );
          }
        },
      ),
    );
  }
}
