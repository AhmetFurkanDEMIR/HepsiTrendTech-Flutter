import 'package:flutter/material.dart';
import 'package:flutter_rest_api/pages/login_page.dart';
import 'package:flutter_rest_api/pages/sign_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void toogleScreens()
  {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage)
    {
      return LoginPage(showSignPage: toogleScreens,);
    }
    else
    {
      return SignPage(showloginPage: toogleScreens,);
    }
  }
}