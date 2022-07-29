import 'dart:convert';

import 'package:api_review/model/category.dart';
import 'package:http/http.dart'as http ;

import '../api_setting.dart';

class CategoryApiController{
  Future<List<Categories>> categories() async {
    var url = Uri.parse(ApiSetting.categories);
    var response = await http.get(url);
    print('response.statusCode is ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      List<Categories> user = jsonArray.map((e) => Categories.fromJson(e)).toList();
      return user;
    }
    return [];
  }
}