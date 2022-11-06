import 'package:flutter/material.dart';

class forgotPass extends StatefulWidget {
  const forgotPass({super.key});

  @override
  State<forgotPass> createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Pass'),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
    );
  }
}
