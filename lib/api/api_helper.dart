import 'dart:io';

import 'package:api_review/model/api_response.dart';
import 'package:api_review/storeg/pref_controller.dart';

mixin ApiHelper {



  ApiResponse<T> getGenericErrorServer<T>(){
 return  ApiResponse<T>(message: 'Something went wrong', status: false);
  }

  ApiResponse get errorServer =>
      ApiResponse(message: 'Something went wrong', status: false);

  Map<String, String> get headers {
    Map<String, String> headers = <String, String>{};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPreferenceController().loggedIn) {
      headers[HttpHeaders.authorizationHeader] =
          SharedPreferenceController().token;
    }
    return headers;
  }
}
