import 'dart:convert';
import 'package:http/http.dart' as http;
import '../item/catalog.dart';

class ApiService {
  static const String url = 'http://10.0.2.2:8000/api/menu/all';
  

  static Future<List<catalog>> fetchCatalog(int storeId) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> body = jsonResponse['data'];
      List<catalog> products = body.map((dynamic item) => catalog.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
  
}
