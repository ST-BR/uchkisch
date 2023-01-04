import 'package:get/get.dart';
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
}
