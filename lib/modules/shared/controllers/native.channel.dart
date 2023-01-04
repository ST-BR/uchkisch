import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NativeChannel extends GetxService {
  final channel = const MethodChannel("ru.stbr.uchkisch");

  Future<void> hide() async {
    await channel.invokeMethod("hide");
  }

  Future<void> show() async {
    await channel.invokeMethod("show");
  }
}
