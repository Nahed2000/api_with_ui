import 'dart:convert';
import 'dart:io';

import 'package:api_review/api/api_controller/student_image_api_controller.dart';
import 'package:api_review/model/api_response.dart';
import 'package:api_review/model/student_image.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

typedef UploadCallBack = void Function(ApiResponse apiResponse);

class ImageGetXcController extends GetxController {
  static ImageGetXcController get to => Get.find();

  final StudentImageApiController _imageApiController =
      StudentImageApiController();

  RxList<StudentImage> listImage = <StudentImage>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    readImage();
    super.onInit();
  }

  void readImage() async {
    loading.value = true;
    ApiResponse<StudentImage> apiResponse =
        await _imageApiController.indexImage();
    loading.value = false;
    if (apiResponse.status) listImage.value = (apiResponse.data) ?? [];
  }

  Future<void> uploadImage({
    required File file,
    required UploadCallBack uploadCallBack,
  }) async {
    StreamedResponse streamedResponse =
        await _imageApiController. uploadImage(file: file);
    streamedResponse.stream.transform(utf8.decoder).listen((String body) {
      if (streamedResponse.statusCode == 201) {
        var jsonResponse = jsonDecode(body);
        StudentImage studentImage =
            StudentImage.fromJson(jsonResponse['object']);
        listImage.add(studentImage);
        uploadCallBack(ApiResponse(
            message: jsonResponse['message'], status: jsonResponse['status']));
      }
    });
  }

  Future<ApiResponse> deleteImage({required index}) async {
    ApiResponse apiResponse =
        await _imageApiController.delete(id: listImage[index].id);
    if (apiResponse.status) {
      listImage.removeAt(index);
    }
    return apiResponse;
  }
}
