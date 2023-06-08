import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_rest_api/models/user_token_model.dart';
import 'package:get_storage/get_storage.dart';

class Service {
  final String baseUrl = "https://users.hepsitrend.tech:2053/";
  final dio = Dio();

  Future<UserToken?> loginFunction(
      {required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        Map<String, String> userInformationMap = <String, String>{};
        userInformationMap['user_email'] = email;
        userInformationMap['user_password'] = password;
        final response =
            await dio.post('${baseUrl}user/login', data: userInformationMap);
        if (response.statusCode == 200) {
          var result = UserToken.fromJson(response.data);
          return result;
        } else {
          return null;
        }
      }
    } on Exception catch (exp) {
      log('Hata: $exp');
    }
  }

  Future<String?> SignFunction(
      {required String userName,
      required String userSurname,
      required String email,
      required String phone,
      required String password,
      required String earlyAccess}) async {
    try {
      if (userName.isNotEmpty &&
          userSurname.isNotEmpty &&
          email.isNotEmpty &&
          phone.isNotEmpty &&
          password.isNotEmpty &&
          earlyAccess.isNotEmpty) {
        Map<String, dynamic> data = {
          "user_name": userName,
          "user_surname": userSurname,
          "user_email": email,
          "user_phone": phone,
          "user_password": password,
          "user_code": earlyAccess
        };

        Response response = await dio.post(
            'https://users.hepsitrend.tech:2053/user/register',
            data: data);
        if (response.statusCode == 201) {
          log("Gelen Response => ${response.data}");
          return response.data;
        } else {
          log("Gelen Response => ${response.data}");
          return response.data;
        }
      } else {
        return 'Bilgileri tamamiyle doldurduğunuzdan emin olun';
      }
    } catch (e) {
      if (e is DioError) {
        log('Hata kodu: ${e.response?.statusCode}');
        log('Hata mesajı: ${e.response?.statusMessage}');
      } else {
        log('Hata kodu: $e');
      }
    }
  }

  Future<List?> uploadImage(Uint8List image, String gender) async {
    log('=>>>' + gender);
    const url =
        'https://prediction.hepsitrend.tech:8443/predict/?user_id={user_id}&gender={gender}';

    //final image = Uint8List(10);
    final token = GetStorage().read('token');

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(image, filename: 'image.jpg'),
    });

    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await dio.post(
        url.replaceAll('{user_id}', '44').replaceAll('{gender}', '$gender'),
        data: formData,
      );
      final responseData = response.data;
      log(' Data => ' + responseData.toString());
      return responseData;
    } catch (e) {
      log('Error: $e');
    }
  }
}
