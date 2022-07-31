import 'dart:async';
import 'dart:convert';

import 'package:api_review/api/api_setting.dart';
import 'package:api_review/model/student.dart';
import 'package:api_review/storeg/pref_controller.dart';
import 'package:http/http.dart' as http;

import '../../model/api_response.dart';
import '../api_helper.dart';

class AuthApiController with ApiHelper {
  Future<ApiResponse> register({required Student student}) async {
    var url = Uri.parse(ApiSetting.register);
    var response = await http.post(url, body: {
      "full_name": student.fullName,
      "password": student.password,
      "gender": student.gender,
      "email": student.email,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServer;
  }

  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse(ApiSetting.login);
    var response = await http.post(url, body: {
      "password": password,
      "email": email,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var jsonObject = jsonResponse['object'];
        Student student = Student.fromJson(jsonObject);
        SharedPreferenceController().save(student: student);
        return ApiResponse(
            message: jsonResponse['message'], status: jsonResponse['status']);
      }
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }

    return errorServer;
  }

  Future<ApiResponse> forget({required String email}) async {
    var url = Uri.parse(ApiSetting.forget);
    var response = await http.post(url, body: {
      "email": email,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) print(jsonResponse['code']);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServer;
  }

  Future<ApiResponse> reset({
    required String password,
    required String code,
    required String email,
  }) async {
    var url = Uri.parse(ApiSetting.reset);
    var response = await http.post(url, body: {
      "code": code,
      "email": email,
      "password": password,
      "password_confirmation": password,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServer;
  }
    Future<ApiResponse> logout() async {
    var url = Uri.parse(ApiSetting.logout);
    var response = await http.get(url,headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      var jsonResponse = jsonDecode(response.body);
      if(response.statusCode==200){
       unawaited( SharedPreferenceController().clear());
        return ApiResponse(
            message: jsonResponse['message'], status: jsonResponse['status']);
      }
      print(response.statusCode);
    return ApiResponse(message: 'Logged out Successfully', status: false);
    }
    return errorServer;
  }
}