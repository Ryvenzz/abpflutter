import 'dart:convert';
import 'package:http/http.dart' as http;
import '../item/Product.dart';
import '../item/Shop.dart';

class ApiService {
  static const String MenuUrl = 'http://10.0.2.2:8000/api/menu/all';
  static const String shopUrl = 'http://10.0.2.2:8000/api/shop/all';
  static const String MenuUrlbyshop = 'http://10.0.2.2:8000/api/shop/all';
  static const String loginUrl = 'http://10.0.2.2:8000/api/login';
  static const String RegisterUrl = 'http://10.0.2.2:8000/api/register';



  //Get
  static Future<List<Product>> fetchProduct() async {
    final response = await http.get(Uri.parse(MenuUrl));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['data'];
      List<Product> products = data.map((item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load menus');
    }
  }


  //Get All shop
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


  //Login
  static Future<String> login(String nickname, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nickname': nickname,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String token = jsonResponse['data']['token'];
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  //Register
  static Future registerUser({
    required String nickname,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String role,
    required String address,
  }) async {
    final url = Uri.parse(RegisterUrl);

    final Map<String, dynamic> requestBody = {
      'nickname': nickname,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role,
      'address': address,
    };

    final response = await http.post(
      url,
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Successful registration
      return jsonDecode(response.body);
    } else {
      // Registration failed
      throw Exception('Failed to register user');
    }
  }

  
}