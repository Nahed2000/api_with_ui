import 'dart:convert';

import 'package:api_review/model/category.dart';
import 'package:api_review/model/image.dart';
import 'package:http/http.dart'as http ;

import '../api_setting.dart';

class UserImageApiController{
  Future<List<UserImage>> userImage() async {
    var url = Uri.parse(ApiSetting.userImage);
    var response = await http.get(url);
    print('response.statusCode is ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      print('response.statusCode is ${response.statusCode}');
      List<UserImage> user = jsonArray.map((e) => UserImage.fromJson(e)).toList();
      return user;
    }
    return [];
  }
}