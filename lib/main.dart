import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      home: LoadingScreen(),
    );
  }
}
