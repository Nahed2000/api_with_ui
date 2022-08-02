import 'package:api_review/api/api_setting.dart';
import 'package:api_review/get/image_getx_controller.dart';
import 'package:api_review/model/api_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/helper.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> with Helper{
  ImageGetXcController _controller = Get.put(ImageGetXcController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Images Screen',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/upload_image'),
            icon: const Icon(Icons.camera_alt_outlined),
          )
        ],
      ),
      body: GetX<ImageGetXcController>(
        builder: (controller) {
          if (controller.loading.isTrue) {
            return const CircularProgressIndicator();
          } else if (controller.listImage.isNotEmpty) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: ApiSetting.image +
                            controller.listImage[index].imageUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.listImage[index].image,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () async=>await _deleteImage(index: index),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade800,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: controller.listImage.length,
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
  Future<void>_deleteImage({required int index})async{
    ApiResponse apiResponse =await ImageGetXcController.to.deleteImage(index: index);
    showSnackBar(context, message: apiResponse.message, error: !apiResponse.status);
  }
}
