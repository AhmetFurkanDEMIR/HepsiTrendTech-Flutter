import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/auth/auth_page.dart';
import 'package:flutter_rest_api/pages/account_page.dart';
import 'package:get_storage/get_storage.dart';

class UiUpdatePage extends StatefulWidget {
  final String name;
  final String surname;
  final String email;
  const UiUpdatePage(
      {super.key,
      required this.name,
      required this.surname,
      required this.email});

  @override
  State<UiUpdatePage> createState() => _UiUpdatePageState();
}

class _UiUpdatePageState extends State<UiUpdatePage> {
  final nameTextEditingController = TextEditingController();
  final surnameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  void updateFunction() async {
    try {
      if ((nameTextEditingController.text.isNotEmpty &&
              surnameTextEditingController.text.isNotEmpty &&
              passwordTextEditingController.text.isNotEmpty) &&
          (widget.name != nameTextEditingController.text &&
              widget.surname != surnameTextEditingController.text)) {
        Map<String, dynamic> data = {
          "user_email": widget.email,
          "user_name": nameTextEditingController.text,
          "user_surname": surnameTextEditingController.text,
          "user_password": passwordTextEditingController.text,
        };
        final String token = GetStorage().read("token");
        Dio dio = Dio();
        dio.options.headers["Authorization"] = "Bearer $token";
        Response response = await dio.put(
          'https://users.hepsitrend.tech:2053/user/',
          data: data,
        );
        FocusScope.of(context).unfocus();

        if (response.statusCode == 202) {
          resultMessageFunction(true);
        } else {
          resultMessageFunction(false);
        }
      }
    } catch (e) {
      if (e is DioError) {
        resultMessageFunction(false);
        log('Hata kodu: ${e.response?.statusCode}');
        log('Hata mesajı: ${e.response?.statusMessage}');
      } else {
        log('Hata: $e');
      }
    }
  }

  void deleteAccountFunction() async {
    try {
      if (passwordTextEditingController.text.isNotEmpty) {
        Map<String, dynamic> data = {
          "user_email": widget.email,
          "user_password": passwordTextEditingController.text,
        };
        final String token = GetStorage().read("token");
        Dio dio = Dio();
        dio.options.headers["Authorization"] = "Bearer $token";
        Response response = await dio.delete(
          'https://users.hepsitrend.tech:2053/user/',
          data: data,
        );
        GetStorage().remove("token");
        FocusScope.of(context).unfocus();

        if (response.statusCode == 202) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Hesabınız silindi"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Tamam',
          onPressed: () {},
        ),
      ),
    );
        } else {
          resultMessageFunction(false);
        }
      }
    } catch (e) {
      if (e is DioError) {
        resultMessageFunction(false);
        log('Hata kodu: ${e.response?.statusCode}');      
        log('Hata mesajı: ${e.response?.statusMessage}');
      } else {
        log('Hata: $e');
      }
    }
  }

  void resultMessageFunction(bool isCompleted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: isCompleted == true
            ? const Text(
                'Bilgileriniz güncellendi!',
              )
            : const Text("İşlem gerçekleştirilemedi. Tekrar deneyiniz"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Tamam',
          onPressed: () {},
        ),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AccountPage(),
      ),
    );
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    surnameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text('Hesap bilgilerini güncele'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 52.0, vertical: 4.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextField(
                controller: nameTextEditingController,
                style: _textStyle1(),
                decoration: InputDecoration(
                  hintText: widget.name,
                  hintStyle: _textStyle(),
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
                controller: surnameTextEditingController,
                style: _textStyle1(),
                decoration: InputDecoration(
                  hintText: widget.surname,
                  hintStyle: _textStyle(),
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
                controller: passwordTextEditingController,
                style: _textStyle1(),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Şifre',
                  hintStyle: _textStyle(),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 52.0, vertical: 10.0),
            child: MaterialButton(
              height: MediaQuery.of(context).size.height * 0.1,
              onPressed: () => updateFunction(),
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                "Güncelle",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 52.0, vertical: 10.0),
            child: MaterialButton(
              height: MediaQuery.of(context).size.height * 0.1,
              onPressed: () => deleteAccountFunction(),
              color: const Color.fromARGB(255, 196, 45, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                "Hesabı sil",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: Colors.black54,
      fontSize: MediaQuery.of(context).size.width /
          42 *
          MediaQuery.of(context).devicePixelRatio,
    );
  }

  TextStyle _textStyle1() {
    return TextStyle(
      color: Colors.black,
      fontSize: MediaQuery.of(context).size.width /
          42 *
          MediaQuery.of(context).devicePixelRatio,
    );
  }
}