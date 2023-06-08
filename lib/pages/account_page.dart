import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/auth/auth_page.dart';
import 'package:flutter_rest_api/pages/uiupdate_page.dart';
import 'package:get_storage/get_storage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final box = GetStorage();
  bool loading = false;
  String name = '';
  String surname = '';
  String email = '';
  String phone = '';

  void logoutFunction() async {
    box.remove("token");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }
  void uIUpdatePage(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UiUpdatePage(name: name, surname: surname, email: email),
      ),
    );
  }

  void getUserInformation() async {
    try {
      final String token = box.read("token");
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      final String baseUrl =
          'https://users.hepsitrend.tech:2053/user/getUser/$token';
      var response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        log("Gelen Response => ${response.data}");
        setState(() {
          name = response.data['user_name'];
          surname = response.data['user_surname'];
          email = response.data['user_email'];
          phone = response.data['user_phone'];
          loading = true;
        });
        //return result;
      } else {
        throw ("Bir sorun oluştu ${response.statusCode}");
      }
    } on Exception catch (e) {
          log('Hata: $e');

    }
  }

  @override
  void initState() {
    getUserInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Hesap'),
            centerTitle: true,
            
          ),
          body: Center(
            child: loading == false?
            const CircularProgressIndicator(
                    color: Color.fromARGB(255, 225, 113, 15)) 
            :Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 52.0, vertical: 10.0),
                  child: Text('Ad: \n$name', textAlign: TextAlign.start, style: _textStyle(),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 52.0, vertical: 10.0),
                  child: Text('Soyad: \n$surname', textAlign: TextAlign.start, style: _textStyle()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 52.0, vertical: 10.0),
                  child: Text('email: \n$email', textAlign: TextAlign.start, style: _textStyle()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 52.0, vertical: 10.0),
                  child: Text('Telefon: \n$phone', textAlign: TextAlign.start, style: _textStyle()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 52.0, vertical: 10.0),
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height * 0.1,
                    // onPressed: () => logoutFunction(),
                    onPressed: () => uIUpdatePage(),
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text(
                      "Hesap ayarları",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 52.0, vertical: 10.0),
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height * 0.1,
                    onPressed: () => logoutFunction(),
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text(
                      "Çıkış!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: MediaQuery.of(context).size.width /
          60 *
          MediaQuery.of(context).devicePixelRatio,
    );
  }
}