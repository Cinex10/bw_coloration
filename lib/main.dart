import 'package:flutter/material.dart';
import 'package:mini_projet_mobile/home_screen.dart';
import 'package:mini_projet_mobile/result_screen.dart';
import 'package:mini_projet_mobile/video_colorization.dart';
import 'package:mini_projet_mobile/video_result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(
          // colorized: '',
          // original: '',
          ),
    );
  }
}
