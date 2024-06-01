import 'package:flutter/material.dart';
import '../API/api_service.dart'; // Sesuaikan dengan lokasi file ApiService

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(labelText: 'Nickname'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _registerUser();

              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser() async {
  String nickname = _nicknameController.text;
  String password = _passwordController.text;
  String fullName = _fullNameController.text;
  String phoneNumber = _phoneNumberController.text;
  String address = _addressController.text;
  String role = 'Buyer'; // Default role for registration

  try {
    // Mencoba melakukan registrasi
    await ApiService.registerUser(
      nickname: nickname,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      role: role,
      address: address,
    );

    // Registrasi berhasil, kembali ke halaman login
    _showSuccessDialog();
  } catch (e) {
    // Registrasi gagal, tampilkan pesan kesalahan
    _showErrorDialog();
  }
}

void _showSuccessDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Registration Successful'),
      content: Text('You have successfully registered.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Tutup dialog
            Navigator.pushReplacementNamed(context, '/login'); // Kembali ke halaman login
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

void _showErrorDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Registration Failed'),
      content: Text('Failed to register user. Please try again.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

}
