import 'package:flutter/material.dart';
import 'package:social_media_app/features/auth/presentation/pages/auth_page.dart';
import 'package:social_media_app/themes/light_mode.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      home: const AuthPage(),
      theme: lightMode,
      debugShowCheckedModeBanner: false,
    );
  }
}