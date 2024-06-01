import 'dart:convert';
import 'package:http/http.dart' as http;
import '../item/Product.dart';
import '../item/Shop.dart';

class ApiService {
  static const String url = 'http://10.0.2.2:8000/api/menu/all';
  static const String shopUrl = 'http://10.0.2.2:8000/api/shop/all';
  

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> body = jsonResponse['data'];
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
  static Future<List<Shop>> fetchShops() async {
    final response = await http.get(Uri.parse(shopUrl));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['data'];
      List<Shop> shops = data.map((dynamic item) => Shop.fromJson(item)).toList();
      return shops;
    } else {
      throw Exception('Failed to load shops');
    }
  }
}