import 'dart:io';

import 'package:api_review/get/image_getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/helper.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> with Helper {
  XFile? _pikedImage;
  late ImagePicker _imagePicker;
  double? progressValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    _imagePicker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Upload Image ',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.green.shade100,
              color: Colors.green,
              minHeight: 7,
              value: progressValue,
            ),
            Expanded(
              child: _pikedImage == null
                  ? IconButton(
                      onPressed: () async => await _pickImage(),
                      icon: const Icon(Icons.camera_alt_outlined, size: 80))
                  : Image.file(
                      File(_pikedImage!.path),
                    ),
            ),
            ElevatedButton.icon(
              onPressed: () async => await performUpload(),
              label: const Text('Upload Image '),
              icon: const Icon(
                Icons.cloud_upload,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                minimumSize: const Size(
                  double.infinity,
                  60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 200
    );
    setState(
      () {
        if (image != null) {
          _pikedImage = image;
        }
      },
    );
  }

  Future<void> performUpload() async {
    if (checkData()) {
      await upload();
    }
  }

  bool checkData() {
    if (_pikedImage != null) {
      return true;
    }
    showSnackBar(context, message: 'Please Pick Image to Upload', error: true);
    return false;
  }

  Future<void> upload() async {
    await ImageGetXcController.to.uploadImage(
        file: File(_pikedImage!.path),
        uploadCallBack: (apiResponse) {
          updateValueOfLinearIndicator(value: apiResponse.status ? 1 : 0);

          showSnackBar(context,
              message: apiResponse.message, error: !apiResponse.status);
        });
  }

  void updateValueOfLinearIndicator({double? value}) {
    setState(() {
      progressValue = value;
    });
  }
}
