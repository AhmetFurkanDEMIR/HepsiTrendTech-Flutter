import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/pages/home_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_rest_api/service/service.dart';
class LoginPage extends StatefulWidget {
  final VoidCallback showSignPage;
  const LoginPage({key, required this.showSignPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController eMailTextEditController = TextEditingController();
  final TextEditingController passwordTextEditController =
      TextEditingController();
  final box = GetStorage();
  final service = Service();

  void onPressedLogInFunc() async {
    service
        .loginFunction(
            email: eMailTextEditController.text,
            password: passwordTextEditController.text)
        .then((value) {
      if (value != null) {
        box.write("token", value.accessToken);
        // log("Kaydedilen Token => ${box.read("token")}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // log('Login else');
      }
    });
  }

  @override
  void dispose() {
    eMailTextEditController.dispose();
    passwordTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedContainer(
          duration: const Duration(seconds: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 100, right: 50, left: 50, bottom: 1),
                      child: Container(
                          child: Image.asset('lib/assets/logo.png')))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 52.0, vertical: 4.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextField(
                        controller: eMailTextEditController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: "E-Mail",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 52.0, vertical: 4.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextField(
                        controller: passwordTextEditController,
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 52.0, vertical: 2.0),
                    child: MaterialButton(
                      height: MediaQuery.of(context).size.height * 0.1,
                      onPressed: () => onPressedLogInFunc(),
                      color: const Color.fromARGB(255, 225, 113, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 225, 113, 15),
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        "Giriş yap!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, left: 52.0, right: 52.0, bottom: 45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hesabın yok mu? ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width /
                                  50 *
                                  MediaQuery.of(context).devicePixelRatio),
                        ),
                        GestureDetector(
                          onTap: widget.showSignPage,
                          child: Text(
                            "Kayıt ol!",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: MediaQuery.of(context).size.width /
                                  50 *
                                  MediaQuery.of(context).devicePixelRatio,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}