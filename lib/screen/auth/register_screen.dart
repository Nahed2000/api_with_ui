import 'package:api_review/api/api_controller/auth_api_controller.dart';
import 'package:api_review/model/api_response.dart';
import 'package:api_review/util/helper.dart';
import 'package:api_review/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/student.dart';
import '../../widget/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helper {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _fullNameController;

  String gender = 'M';

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Register Screen',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.s,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome...!!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'please enter your email, password to register ,and your gender',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _fullNameController,
                hintText: 'Full Name',
                prefixIcon: Icons.person_outline_sharp,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                obSecured: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 'M',
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) {
                            gender = value;
                          }
                        });
                      },
                      title: Text('Male'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: 'F',
                      groupValue: gender,
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) {
                            gender = value;
                          }
                        });
                      },
                      title: Text('Female'),
                    ),
                  ),
                ],
              ),
              CustomButton(
                  onPress: () async => await _performRegister(),
                  title: 'Register'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        message:
            'Required Data, Please Enter your information Password, Email and full Name ',
        error: true);
    return false;
  }

  Future<void> register() async {
    ApiResponse apiResponse =
        await AuthApiController().register(student: student);
    showSnackBar(context,
        message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
  }

  Student get student {
    Student student = Student();
    student.gender = gender;
    student.email = _emailController.text;
    student.password = _passwordController.text;
    student.fullName = _fullNameController.text;
    return student;
  }
}
