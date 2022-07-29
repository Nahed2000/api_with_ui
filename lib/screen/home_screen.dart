import 'package:flutter/material.dart';

import '../widget/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomButton(
                title: 'Category',
                routeName: '/categories_screen',
              ),
              SizedBox(height: 20),
              CustomButton(
                title: 'Category Product',
                routeName: '/category_product',
              ),
              SizedBox(height: 20),
              CustomButton(
                title: 'User Image',
                routeName: '/user_image_screen',
              ),
              SizedBox(height: 20),
              CustomButton(
                title: 'User Index',
                routeName: '/user_index',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
