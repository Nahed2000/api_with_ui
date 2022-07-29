import 'package:api_review/api/api_controller/auth_api_controller.dart';
import 'package:api_review/model/api_response.dart';
import 'package:api_review/util/helper.dart';
import 'package:api_review/widget/custom_button.dart';
import 'package:api_review/widget/custom_text_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with Helper {
  late TextEditingController _password;
  late TextEditingController _passwordConfirmation;
  late TextEditingController firstController;
  late TextEditingController secondController;
  late TextEditingController thirdController;
  late TextEditingController forthController;

  late FocusNode firstNode;
  late FocusNode secondNode;
  late FocusNode thirdNode;
  late FocusNode forthNode;

  String code = '';

  @override
  void initState() {
    // TODO: implement initState
    _password = TextEditingController();
    _passwordConfirmation = TextEditingController();
    firstController = TextEditingController();
    secondController = TextEditingController();
    thirdController = TextEditingController();
    forthController = TextEditingController();

    firstNode = FocusNode();
    secondNode = FocusNode();
    thirdNode = FocusNode();
    forthNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _password.dispose();
    _passwordConfirmation.dispose();
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    forthController.dispose();
    firstNode.dispose();
    secondNode.dispose();
    thirdNode.dispose();
    forthNode.dispose();
    super.dispose();
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
          'Reset Password',
          style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forget Password ...!!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'please enter your code,new password and  password Confirmation ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _password,
                hintText: 'new password',
                prefixIcon: Icons.lock,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _passwordConfirmation,
                hintText: 'confirmation password',
                prefixIcon: Icons.lock,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextCode(
                      controller: firstController,
                      node: firstNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          secondNode.requestFocus();
                        }
                      }),
                  const SizedBox(width: 10),
                  CustomTextCode(
                      controller: secondController,
                      node: secondNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          thirdNode.requestFocus();
                        } else {
                          firstNode.requestFocus();
                        }
                      }),
                  const SizedBox(width: 10),
                  CustomTextCode(
                      controller: thirdController,
                      node: thirdNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          forthNode.requestFocus();
                        } else {
                          secondNode.requestFocus();
                        }
                      }),
                  const SizedBox(width: 10),
                  CustomTextCode(
                      controller: forthController,
                      node: forthNode,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          thirdNode.requestFocus();
                        }
                      }),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                  onPress: () async => await _performReset(),
                  title: 'Sent a Code'),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performReset() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (getPassword() && getCode()) {
      return true;
    }
    return false;
  }

  Future<void> resetPassword() async {
    ApiResponse apiResponse = await AuthApiController()
        .reset(password: _password.text, code: code, email: widget.email);
    showSnackBar(context,
        message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

  bool getPassword() {
    if (_password.text.isNotEmpty && _passwordConfirmation.text.isNotEmpty) {
      if (_password.text == _passwordConfirmation.text) {
        return true;
      }
      showSnackBar(context,
          message: ',Password and Confirmation Password dose not match',
          error: true);
      return false;
    }
    showSnackBar(context,
        message:
            'Required Data , Please Enter password and confirmation password',
        error: true);
    return false;
  }

  bool getCode() {
    if (firstController.text.isNotEmpty &&
        secondController.text.isNotEmpty &&
        thirdController.text.isNotEmpty &&
        forthController.text.isNotEmpty) {
      setState(() {
        code = firstController.text +
            secondController.text +
            thirdController.text +
            forthController.text;
      });
      return true;
    }
    showSnackBar(context, message: 'Please Enter Your Code', error: true);
    return false;
  }
}
