import 'package:api_review/screen/auth/login_screen.dart';
import 'package:api_review/screen/auth/register_screen.dart';
import 'package:api_review/screen/category/categories_screen.dart';
import 'package:api_review/screen/category/categoty_product.dart';
import 'package:api_review/screen/home_screen.dart';
import 'package:api_review/screen/lunch_screen.dart';
import 'package:api_review/screen/user/user_image_screen.dart';
import 'package:api_review/screen/user/user_index.dart';
import 'package:api_review/storeg/pref_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'screen/auth/forget_password.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'/login_screen',
        routes:
        {
          '/lunch_screen':(context) =>const LunchScreen(),
          '/login_screen':(context) =>const LoginScreen(),
          '/register_screen':(context) =>const RegisterScreen(),
          '/forget_password':(context) =>const ForgetPassword(),
          '/home_screen':(context) =>const HomeScreen(),
          '/categories_screen':(context) =>const CategoriesScreen(),
          '/category_product':(context) =>const CategoryProductScreen(),
          '/user_image_screen':(context) =>const UserImageScreen(),
          '/user_index':(context) =>const UserIndexScreen(),
        }
    );
  }
}
