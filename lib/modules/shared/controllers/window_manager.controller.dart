import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:uchkisch/config/window.dart';
import 'package:uchkisch/modules/shared/controllers/native.channel.dart';
import 'package:window_manager/window_manager.dart';

class WindowManagerController extends GetxController {
  final nativeChannel = Get.put(NativeChannel());
  var _collapsed = false;

  @override
  void onInit() async {
    super.onInit();
    await windowManager.ensureInitialized();
    windowManager.addListener(_OnBlurWindowListener(onBlur: hide));
  }

  collapse() async {
    if (!_collapsed) {
      await windowManager.setSize(COLLAPSED_WINDOW_SIZE, animate: true);
    }
    _collapsed = true;
  }

  expand() async {
    if (_collapsed) {
      await windowManager.setSize(EXPANDED_WINDOW_SIZE, animate: true);
    }
    _collapsed = false;
  }

  toggleShow() async {
    var isFocused = await windowManager.isFocused();
    if (isFocused) {
      await hide();
    } else {
      await show();
    }
  }

  show() async {
    var screen = await screenRetriever.getPrimaryDisplay();
    var windowRect = await windowManager.getBounds();
    var position = Offset(
      screen.size.width / 2 - windowRect.width / 2,
      screen.size.height / 4,
    );
    await windowManager.setPosition(position);
    await windowManager.show();
    await windowManager.focus();
    // windowManager
  }

  hide() async {
    await Future.wait([nativeChannel.hide()]);
  }
}

class _OnBlurWindowListener extends WindowListener {
  _OnBlurWindowListener({required this.onBlur});

  Function() onBlur;

  @override
  void onWindowBlur() {
    onBlur();
    super.onWindowBlur();
  }
}
