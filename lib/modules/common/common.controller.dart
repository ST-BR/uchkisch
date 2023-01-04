import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:uchkisch/modules/shared/controllers/window_manager.controller.dart';

class CommonController extends GetxController {
  final inputValue = ''.obs;
  final windowManagerController = Get.find<WindowManagerController>();

  @override
  onInit() async {
    super.onInit();
    inputValue.listen((inputValue) {
      if (inputValue.isEmpty) {
        windowManagerController.collapse();
      } else {
        windowManagerController.expand();
      }
    });
  }

  onKeyEvent(KeyEvent event) {
    if (event.logicalKey.keyId == KeyCode.escape.keyId) {
      if (inputValue.value.isEmpty) {
        windowManagerController.hide();
      } else {
        inputValue.value = '';
      }
    }
  }
}
