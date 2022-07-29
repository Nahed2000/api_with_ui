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
            children: [
              CustomButton(
                title: 'Category',
                onPress: () => Navigator.pushNamed(context, '/categories_screen'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Category Product',
                onPress: () => Navigator.pushNamed(context, '/category_product'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'User Image',
                onPress: () => Navigator.pushNamed(context, '/user_image_screen'),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'User Index',
                onPress: () => Navigator.pushNamed(context, '/user_index'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
