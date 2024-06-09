import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    final String nickname = _nicknameController.text;
    final String password = _passwordController.text;

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
    

      if (jsonResponse['data'] != null && jsonResponse['data']['data'] != null) {
        // Jika respons memiliki data dan data pengguna
        // Ini menunjukkan bahwa pengguna berhasil login
        // Lakukan sesuatu di sini, misalnya navigasi ke halaman beranda
        String token = jsonResponse['data']['data']['token'];
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {'token': token, 'nickname': nickname},
          );
      } else if (jsonResponse['data'] != null &&
          jsonResponse['data']['status'] == 'failed') {
            setState(() {
            _errorMessage = "Akun telah login di device lain";
          });
        // Jika respons memiliki data tetapi statusnya 'failed'
        // Ini menunjukkan bahwa akun sudah login sebelumnya
        // Lakukan sesuatu di sini, misalnya tampilkan pesan bahwa akun sudah login
      } else {
        // Jika respons tidak sesuai dengan format yang diharapkan
        // Lakukan sesuatu di sini, misalnya tampilkan pesan kesalahan
        setState(() {
            _errorMessage = "Error Credential";
          });
      }
    } else {
      setState(() {
        _errorMessage = 'Login failed. Please check your credentials.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Menggunakan Center untuk menengahkan kotak login
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [const Color.fromARGB(255, 236, 19, 4).withOpacity(0.8), Color.fromARGB(255, 32, 3, 1).withOpacity(0.8)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Login Form',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      hintText: 'Nickname',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 236, 19, 4).withOpacity(0.8),const Color.fromARGB(255, 32, 3, 1).withOpacity(0.8)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),  
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.transparent,
                        elevation: 0, // No shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),  
                      ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman registrasi
                      Navigator.pushNamed(context, '/registration');
                    },
                    child: Text(
                      'Don\'t have an account? Register here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                      Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
 
    );
  }
}
