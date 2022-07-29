import 'dart:math';

import 'package:api_review/api/api_controller/category_api_controller.dart';
import 'package:api_review/api/api_controller/category_product_api_controller.dart';
import 'package:api_review/api/api_controller/user_api_controller.dart';
import 'package:api_review/model/category.dart';
import 'package:api_review/model/category_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_index.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({Key? key}) : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  late Future<List<CategoriesProducts>> _future;

  @override
  void initState() {
    // TODO: implement initState
    _future = CategoryProductApiController().categoriesProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Category Product  Screen',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:
          FutureBuilder<List<CategoriesProducts>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child:  CircularProgressIndicator());
              }
              else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) =>  ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.transparent,
                      child: Image.network(snapshot.data![index].image),
                    ),
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].description),
                    trailing: Text(snapshot.data![index].price),
                  ),
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                );
              } else {
                print(snapshot . connectionState);
                print(snapshot . hasData);
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const[
                      Icon(
                        Icons.warning_amber,
                        color: Colors.red,
                      ),
                      Text(
                        "you don't have any Data ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
    );
  }
}
