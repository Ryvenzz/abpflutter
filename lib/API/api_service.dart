import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../item/product.dart';
import '../item/Shop.dart';
import '../item/menushop.dart';
import '../item/booking.dart';
import '../item/menubooking.dart';
import '../item/productresponse.dart';

class ApiService {
  static const String MenuUrl = 'http://10.0.2.2:8000/api/menu/all';
  static const String shopUrl = 'http://10.0.2.2:8000/api/shop/all';
  static const String MenuUrlbyshop = 'http://10.0.2.2:8000/api/shop/all';
  static const String loginUrl = 'http://10.0.2.2:8000/api/login';
  static const String RegisterUrl = 'http://10.0.2.2:8000/api/register';



  //Get All Menu
  static Future<ProductResponse> fetchProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        // Handle the case where the token is not found
        throw Exception('User not authenticated');
      }
      final response2 = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/user/info'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("cek userid ${response2.body}");
      var jsonResponse2 = jsonDecode(response2.body);
      final String nickname = jsonResponse2['data']['nickname'];

    // Panggil endpoint untuk mendapatkan daftar produk
    final response = await http.get(Uri.parse(MenuUrl));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['data'];
      List<Product> products = data.map((item) => Product.fromJson(item)).toList();
      print(products);
      print(nickname);
      // Return ProductResponse yang berisi nickname dan daftar produk
      return ProductResponse(nickname: nickname, products: products);
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

  //logout
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/logout'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('token');
      } else {
        throw Exception('Failed to logout');
      }
    } else {
      throw Exception('No token found');
    }
  }

  //Login
  static Future<String> login(String nickname, String password) async {
    try {
      print(nickname + password);
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
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

        print('Parsed JSON response: $jsonResponse');

        if (jsonResponse['status'] == 'success') {
          var data = jsonResponse['data'];
          if (data['status'] == 'failed') {
            throw Exception(data['message']);
          } else if (data['data'] != null) {
            String token = data['data']['token'];

            // Save the token using SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);

            print('Token saved: $token');
            return token;
          } else {
            throw Exception('Unexpected response format');
          }
        } else {
          throw Exception(jsonResponse['message']);
        }
      } else {
        throw Exception('Failed to login: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to login due to an exception');
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
  }) 
  async {

    print(nickname + ' ' + password + ' ' + fullName + ' ' + role);
    final Map<String, String> requestBody = {
      'nickname': nickname,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role,
      'address': address,
    };
    print(requestBody);

      final response = await http.post(
        Uri.parse(RegisterUrl),
        body: requestBody,
        headers: {'Accept': 'application/json'},
      );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      // Successful registration
      return jsonDecode(response.body);
    } else {
      // Registration failed
      throw Exception('Failed to register user');
    }
  }

  //Get menu by shop
  static Future<List<Menu>> fetchMenuByShop(int shopId) async {
    final Map<String, dynamic> requestData = {'shop_id': shopId};
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/menu/byShop?shop_id=$shopId'),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> body = jsonResponse['data'];
      
      List<Menu> products = body.map((dynamic item) => Menu.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load menu');
    }
  }

  //Add Cart
  static Future<void> addCart(int bookingId, int menuId, int quantity) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        // Handle the case where the token is not found
        throw Exception('User not authenticated');
      }
      
      // print(bookingId.toString() + menuId.toString() + quantity.toString());


      final Map<String, String> requestBody = {
          'bookingId': bookingId.toString(),
          'menuId': menuId.toString(),
          'quantity': quantity.toString(),
      };
        print(requestBody);
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/booking/detail/menu/add'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody
      );
      print("cek add cart ${response.body}");
      if (response.statusCode != 201) {
        // Handle the error
        var errorResponse = jsonDecode(response.body);
        throw Exception('Failed to add to cart: ${errorResponse['message']}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('$e');
    }
  }

  //Get booking id by user
  static Future<int?> getBookingIdByUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        // Handle the case where the token is not found
        throw Exception('User not authenticated');
      }
      final response2 = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/user/info'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("cek userid ${response2.body}");
      var jsonResponse2 = jsonDecode(response2.body);
      final int userid = jsonResponse2['data']['id'];

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/booking/prog/byUser?user_id=$userid'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("cek bookingid ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        print(jsonResponse['data']);
        var data = jsonResponse['data'];
        var id = data[0]['id'];
        print("idnya ${id}");
        return id;
      } else {
        // Handle the error
        throw Exception('Failed to fetch booking ID');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Failed to fetch booking ID: $e');
    }
  }

  //Show Isi keranjang
  static Future<Map<String, dynamic>> showCart(int bookingId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('User not authenticated');
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/booking/detail/menu/$bookingId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to show cart');
      }
    } catch (e) {
      throw Exception('Failed to show cart: $e');
    }
  }

  //Edit cart
  static Future<void> editCart(int bookingId, int menuId, int quantity) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      print(bookingId.toString() + ' ' + menuId.toString() + ' ' + quantity.toString());
      if (token == null) {
        throw Exception('User not authenticated');
      }

      final Map<String, dynamic> requestBody = {
        'bookingId': bookingId.toString(),
        'menuId': menuId.toString(),
        'quantity': quantity.toString(),
      };

      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/booking/detail/menu/edit'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      if (response.statusCode != 200) {
        var errorResponse = jsonDecode(response.body);
        throw Exception('Failed to edit cart: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to edit cart: $e');
    }
  }

  //Delete cart
  static Future<void> deleteCart(int bookingId, int menuId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('User not authenticated');
      }

      final Map<String, dynamic> requestBody = {
        'bookingId': bookingId.toString(),
        'menuId': menuId.toString(),  
      };

      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/booking/detail/menu/delete'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      if (response.statusCode != 200) {
        var errorResponse = jsonDecode(response.body);
        throw Exception('Failed to delete cart: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('Failed to delete cart: $e');
    }
  }

  //Checkout
  static Future<void> checkout(int bookingId, String paymentMethod) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('User not authenticated');
      }

      final Map<String, dynamic> requestBody = {
        'metodePembayaran': paymentMethod.toString(),
        'booking_id': bookingId.toString(),
      };

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/invoice/add'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      if (response.statusCode != 201) {
        var errorResponse = jsonDecode(response.body);
        throw Exception('Failed to checkout: ${errorResponse['message']}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  //Get Invoice
  static Future<List<Booking>> showInvoice() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        // Handle the case where the token is not found
        throw Exception('User not authenticated');
      }
      final response2 = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/user/info'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print("cek userid ${response2.body}");
      var jsonResponse2 = jsonDecode(response2.body);
      final int userid = jsonResponse2['data']['id'];


      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/invoice/all/byUser?user_id=$userid'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print("cek data ${response.body}");
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> bookingData = jsonResponse['data'];
        List<Booking> bookings = bookingData.map((data) => Booking.fromJson(data)).toList();
        return bookings;
      } else {
        // Handle the error
        throw Exception('Failed to fetch invoice data');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Failed to fetch invoice data: $e');
    }
  }

  //Get menu invoice
  static Future<List<MenuBooking>> showMenuBooking(int invoiceId) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('User not authenticated');
    }


    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/invoice/menu/ByBooking?invoice_id=$invoiceId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data['data']['menus']);

      List<MenuBooking> menuBookings = (data['data']['menus'] as List).map((menuJson) => MenuBooking.fromJson(menuJson)).toList();
      return menuBookings;
    } else {
      throw Exception('Failed to load menu booking');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}



}