import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:uchkisch/modules/shared/controllers/window_manager.controller.dart';

class HotKeyManagerController extends GetxController {
  var currentHotKey = HotKey(KeyCode.space, modifiers: [KeyModifier.control]);
  final _windowManagerController = Get.find<WindowManagerController>();

  @override
  void onInit() async {
    super.onInit();

    await hotKeyManager.unregisterAll();
    await hotKeyManager.register(currentHotKey, keyDownHandler: (_) async {
      _windowManagerController.toggleShow();
    });
  }
}
