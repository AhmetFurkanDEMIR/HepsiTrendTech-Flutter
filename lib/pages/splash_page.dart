import 'package:flutter/material.dart';
import 'package:flutter_rest_api/auth/auth_page.dart';
import 'package:flutter_rest_api/pages/home_page.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final box = GetStorage();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (box.read("token") != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [
              0.05,
              0.4,
            ],
            colors: [
              Color.fromARGB(255, 206, 129, 21),
              Color.fromARGB(255, 206, 102, 4),
            ],
          ),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Hayalindeki ürünü ara",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}