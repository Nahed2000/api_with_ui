import 'dart:convert';

import 'package:api_review/model/category.dart';
import 'package:http/http.dart'as http ;

import '../../model/category_product.dart';
import '../api_setting.dart';

class CategoryProductApiController{
  Future<List<CategoriesProducts>> categoriesProducts() async {
    var url = Uri.parse(ApiSetting.categories);
    var response = await http.get(url);
    print('response.statusCode is ${response.statusCode}');
    if (response.statusCode == 200) {
      print('response.statusCode is ${response.statusCode}');
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      print('response.statusCode is ${response.statusCode}');
      List<CategoriesProducts> user = jsonArray.map((e) => CategoriesProducts.fromJson(e)).toList();
      print('user is $user');
      return user;
    }
    print('data is empty');
    return [];
  }
}