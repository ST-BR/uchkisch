import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchkisch/modules/common/common.controller.dart';
import 'package:uchkisch/modules/plugins/plugins.controller.dart';
import 'package:uchkisch/modules/shared/components/plugin.dart';

class PluginList extends StatefulWidget {
  const PluginList({super.key});

  @override
  State<PluginList> createState() => _PluginListState();
}

class _PluginListState extends State<PluginList> {
  final controller = Get.put(PluginsController());
  final commonController = Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return ListView(
          children: controller.plugins
              .map((plugin) => PluginView(
                    pluginName: plugin.name,
                    commands: plugin.commands
                        .where((command) => command.name.toLowerCase().contains(
                            commonController.inputValue.toLowerCase()))
                        .toList(),
                  ))
              .toList(),
        );
      }),
    );
  }
}
