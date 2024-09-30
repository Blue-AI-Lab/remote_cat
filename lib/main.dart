import 'package:flutter/material.dart';
import 'package:remote_cat/home.dart';



void main(){
  runApp(my_app());
}


class my_app extends StatefulWidget {
  const my_app({super.key});

  @override
  State<my_app> createState() => _my_appState();
}

class _my_appState extends State<my_app> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: home(),
    
      debugShowCheckedModeBanner: false,
      
    );
  }
}

