import 'dart:convert';

import 'package:api_review/api/api_setting.dart';
import 'package:http/http.dart' as http;

import '../../model/user_index.dart';

class UserApiController {
  Future<List<UserIndex>> indexUser() async {
    var url = Uri.parse(ApiSetting.indexUser);
    var response = await http.get(url);
    print('response.statusCode is ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      List<UserIndex> user = jsonArray.map((e) => UserIndex.fromJson(e)).toList();
      return user;
    }
    return [];
  }

  Future<List<UserIndex>> searchUser({
    required String firstName,
    required String jobTitle,
  }) async {
    var url = Uri.parse(ApiSetting.searchUser);
    var response = await http.post(url, body: {
      "first_name": firstName,
      "job_title": jobTitle,
    });
    print('response.statusCode is ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      List<UserIndex> user = jsonArray.map((e) => UserIndex.fromJson(e)).toList();
      return user;
    }
    return [];
  }
}
