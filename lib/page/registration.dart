import 'package:flutter/material.dart';
import '../API/api_service.dart'; // Sesuaikan dengan lokasi file ApiService

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              key: _formKey,
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
                      'Register Form',
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Nickname';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      hintText: 'Fullname',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Fullname';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 236, 19, 4).withOpacity(0.8),
                          const Color.fromARGB(255, 32, 3, 1).withOpacity(0.8)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: _registerUser,
                      child: Text(
                        'Register',
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
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman registrasi
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Have an account? Login here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
