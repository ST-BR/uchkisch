import 'package:get/get.dart';
import 'package:uchkisch/modules/common/common.controller.dart';
import 'package:uchkisch/modules/plugins/core_plugins/applications.dart';

import 'models.dart';

class PluginsController extends GetxController {
  final commonController = Get.find<CommonController>();
  final plugins = RxList<Plugin>();

  @override
  void onInit() {
    super.onInit();
    plugins.add(ApplicationsPlugin());
    for (var plugin in plugins) {
      plugin.init();
    }
  }
}
