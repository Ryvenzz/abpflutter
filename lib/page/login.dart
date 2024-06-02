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
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            Text(
              'Don\'t have an account? Register here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
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
    );
  }
}
