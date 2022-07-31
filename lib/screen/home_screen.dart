import 'package:api_review/api/api_controller/auth_api_controller.dart';
import 'package:api_review/model/api_response.dart';
import 'package:api_review/util/helper.dart';
import 'package:flutter/material.dart';

import '../widget/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with Helper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
            ApiResponse apiResponse = await AuthApiController().logout();
            if(apiResponse.status){
              Navigator.pushReplacementNamed(context, '/login_screen');
              showSnackBar(context, message: apiResponse.message, error: !apiResponse.status);
            }
            showSnackBar(context, message: 'Something went wrong', error: true);
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                title: 'Category',
                onPress: () =>
                    Navigator.pushNamed(context, '/categories_screen'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Category Product',
                onPress: () =>
                    Navigator.pushNamed(context, '/category_product'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'User Image',
                onPress: () =>
                    Navigator.pushNamed(context, '/user_image_screen'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'User Index',
                onPress: () => Navigator.pushNamed(context, '/user_index'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Images & Upload Image',
                onPress: () => Navigator.pushNamed(context, '/image_screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
