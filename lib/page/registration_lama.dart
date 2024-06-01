// import 'package:abp/User/user.dart';
// import 'package:flutter/material.dart';

// class RegistrationForm extends StatefulWidget {
//   @override
//   _RegistrationFormState createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<RegistrationForm> {
//   final _formKey = GlobalKey<FormState>();
//   String _name = "";
//   String _email = "";
//   String _password = "";
//   String _confirmPassword = "";

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: Center( // Menggunakan Center untuk menengahkan kotak pendaftaran
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 1.0,
//               ),
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [const Color.fromARGB(255, 236, 19, 4).withOpacity(0.8), Color.fromARGB(255, 32, 3, 1).withOpacity(0.8)],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Text(
//                       'Register Form',
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(height: 20.0),
//                   TextFormField(
//                     initialValue: _name,
//                     decoration: InputDecoration(
//                       hintText: 'Nama',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       setState(() {
//                         _name = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 16.0),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Email Address',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your email address';
//                       } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(value)) {
//                         return 'Please enter a valid email address';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       setState(() {
//                         _email = value!;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 16.0),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your password';
//                       } else if (value.length < 6) {
//                         return 'Password must be at least 6 characters long';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       _password = value!.trim();
//                     },
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 16.0),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       hintText: 'Confirm Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     onSaved: (value) {
//                       _confirmPassword = value!.trim();
//                     },
//                     obscureText: true,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please confirm your password';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20.0),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.0),
//                       gradient: LinearGradient(
//                         colors: [
//                           const Color.fromARGB(255, 236, 19, 4).withOpacity(0.8),const Color.fromARGB(255, 32, 3, 1).withOpacity(0.8)
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                     child: ElevatedButton(
//                      onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         _formKey.currentState!.save();
//                         // Memeriksa apakah password dan konfirmasi password cocok
//                       if (_password != _confirmPassword) {
//                         // Jika tidak cocok, tampilkan pesan kesalahan di bawah TextFormField
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Passwords do not match. Please try again.'),
//                           ),
//                         );
//                       } else {
//                           // Jika cocok, daftarkan pengguna dan pindah ke halaman login
//                           registerUser(_name, _email, _password);
//                           Navigator.pushNamed(context, '/login');
//                         }
//                       }
//                     },
//                       child: Text(
//                         'Register',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(double.infinity, 50),
//                         backgroundColor: Colors.transparent,
//                         elevation: 0, // No shadow
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
