import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/auth/auth_page.dart';
import 'package:flutter_rest_api/service/service.dart';
class SignPage extends StatefulWidget {
  final VoidCallback showloginPage;
  const SignPage({Key? key, required this.showloginPage}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final TextEditingController eMailTextEditController = TextEditingController();
  final TextEditingController userNameTextEditController = TextEditingController();
  final TextEditingController phoneTextEditController = TextEditingController();
  final TextEditingController passwordTextEditController = TextEditingController();
  final TextEditingController userSurnameTextEditController = TextEditingController();
  final TextEditingController earlyAccessTextEditController = TextEditingController();

  void onPressedSignInFunc() async {
    final variable = await Service().SignFunction(
      userName: userNameTextEditController.text, 
      userSurname: userSurnameTextEditController.text, 
      email: eMailTextEditController.text, 
      phone: phoneTextEditController.text, 
      password: passwordTextEditController.text, 
      earlyAccess: earlyAccessTextEditController.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ),
        );
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
                variable.toString(),
              ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Tamam',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameTextEditController.dispose();
    userSurnameTextEditController.dispose();
    eMailTextEditController.dispose();
    phoneTextEditController.dispose();
    passwordTextEditController.dispose();
    earlyAccessTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 52.0, vertical: 4.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextField(
                  controller: userNameTextEditController,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Ad",
                    labelStyle: TextStyle(color: Colors.black, ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 52.0, vertical: 4.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextField(
                  controller: userSurnameTextEditController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Soyad",
                    labelStyle: TextStyle(color: Colors.black,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 52.0, vertical: 4.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextField(
                  controller: eMailTextEditController,
                  style: const TextStyle(color: Colors.black,),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "E-Posta",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 52.0, vertical: 4.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextField(
                  controller: phoneTextEditController,
                  style: const TextStyle(color: Colors.black,),
                  decoration: const InputDecoration(
                    labelText: "Telefon",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 52.0, vertical: 4.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextField(
                  controller: passwordTextEditController,
                  style: const TextStyle(color: Colors.black,),
                  decoration: const InputDecoration(
                    labelText: "Şifre",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 52.0, vertical: 4.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: TextField(
                    controller: earlyAccessTextEditController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: "Erken erişim kodunuz",
                      labelStyle: TextStyle(color: Colors.black,),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 52.0, vertical: 2.0),
                child: MaterialButton(
                  height: MediaQuery.of(context).size.height * 0.1,
                  onPressed: () => onPressedSignInFunc(),
                  color: const Color.fromARGB(255, 225, 113, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 225, 113, 15),
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    "Kayıt Ol!",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 52.0, vertical: 4.0),
                child: Column(children: [
                  Text(
                    "Zaten bir hesabın var mı? ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width /
                            50 *
                            MediaQuery.of(context).devicePixelRatio),
                  ),
                  GestureDetector(
                    onTap: widget.showloginPage,
                    child: Text(
                      "Giriş yap!",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: MediaQuery.of(context).size.width /
                            50 *
                            MediaQuery.of(context).devicePixelRatio,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}