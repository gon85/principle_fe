import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:principle_fe/app/controllers/global/tmp_controller.dart';
import 'package:principle_fe/utils/logs/logger.dart';

class TmpPage extends GetView<TmpController> {
  const TmpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tmp'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: GetX<TmpController>(
            initState: (state) => Get.find<TmpController>(),
            builder: (controller) {
              return Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        logger.i('xxxx????');
                      },
                      child: Text(
                        'DUMMY ${controller.dummy}',
                        style: const TextStyle(fontSize: 20),
                      ))
                ],
              ));
            },
          ),
        ));
  }
}
