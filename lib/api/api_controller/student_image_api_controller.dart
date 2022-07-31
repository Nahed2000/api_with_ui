import 'dart:convert';
import 'dart:io';

import 'package:api_review/api/api_helper.dart';
import 'package:api_review/model/api_response.dart';
import 'package:api_review/model/student_image.dart';
import 'package:http/http.dart' as http;
import 'package:api_review/api/api_setting.dart';

import '../../storeg/pref_controller.dart';

class StudentImageApiController with ApiHelper {
  // Upload , Read ,Delete,//

  Future<http.StreamedResponse> uploadImage({required File file}) async {
    var url = Uri.parse(ApiSetting.image.replaceFirst('{/id}', ''));
    var request = http.MultipartRequest('POST', url);

    //Todo : Upload File
    var imageFile = await http.MultipartFile.fromPath('image', file.path);
    request.files.add(imageFile);

    //Todo: Upload Fields
    //  request.fields['name'] = 'ABC';

    //Todo: Upload Headers
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPreferenceController().token;
    return await request.send();
  }

  Future<ApiResponse<StudentImage>> indexImage() async {
    var url = Uri.parse(ApiSetting.image.replaceFirst('{/id}', ''));
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var jsonArray = jsonResponse['data'] as List;
        List<StudentImage> studentImage =
            jsonArray.map((e) => StudentImage.fromJson(e)).toList();
        return ApiResponse.listImage(
            message: jsonResponse['message'],
            status: jsonResponse['status'],
            data: studentImage);
      }
      return ApiResponse(message: 'You must Login again!', status: false);
    }
    return getGenericErrorServer<StudentImage>();
  }

  Future<ApiResponse> delete({required int id}) async {
    var url = Uri.parse(ApiSetting.image.replaceFirst('{id}', id.toString()));
    var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return ApiResponse(
            message: jsonResponse['message'], status: jsonResponse['status']);
      } else if (response.statusCode == 404 || response.statusCode == 401) {
        String message = response.statusCode == 401
            ? 'you must login again '
            : 'Image not found';
        return ApiResponse(message: message, status: false);
      }
    return errorServer;
  }
}
