import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/auth/login_controller.dart';
import 'package:validators/validators.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: GetX<LoginController>(
            initState: (state) => Get.find<LoginController>(),
            builder: (controller) {
              return Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        initialValue: 'otest001@e2e.com',
                        decoration: InputDecoration(
                            labelText: 'Email ${controller.email}'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 값 입니다.';
                          }
                          if (!isEmail(value)) return 'email 형식이 아닙니다.';
                          return null;
                        },
                        onSaved: (newValue) {
                          controller.email = newValue!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: '01!!xfortesting',
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '필수 값 입니다.';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          controller.pw = newValue!;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: controller.handlePressedLogin,
                          child: Text(
                            'Login${controller.dummy}',
                            style: const TextStyle(fontSize: 20),
                          ))
                    ],
                  ));
            },
          ),
        ));
  }
}
