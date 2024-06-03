import 'package:flutter/material.dart';

class loadingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Image.asset(
          '../aset/1.png',
          fit: BoxFit.contain
        )
      )
    );
  }
}