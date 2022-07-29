import 'dart:math';

import 'package:api_review/api/api_controller/user_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_index.dart';

class UserIndexScreen extends StatefulWidget {
  const UserIndexScreen({Key? key}) : super(key: key);

  @override
  State<UserIndexScreen> createState() => _UserIndexScreenState();
}

class _UserIndexScreenState extends State<UserIndexScreen> {
  late Future<List<UserIndex>> _future;

  @override
  void initState() {
    // TODO: implement initState
    _future = UserApiController().indexUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'User Screen',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:
          FutureBuilder<List<UserIndex>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child:  CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(

                  itemBuilder: (context, index) =>  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      child: Image.network(snapshot.data![index].image),
                      radius: 36,
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].email),
                    trailing: Text(snapshot.data![index].mobile),
                  ),
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                );
              } else {
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
