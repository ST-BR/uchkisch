import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchkisch/modules/common/common.controller.dart';
import 'package:uchkisch/modules/plugins/view.dart';
import 'package:uchkisch/modules/shared/components/input.dart';

class CommonScreen extends StatefulWidget {
  const CommonScreen({super.key});

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  final controller = Get.put(CommonController());
  var inputText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: OverflowBox(
          child: Column(children: [
            CommonInput(
              placeholder: "Search",
              onChanged: (value) async {
                controller.inputValue.value = value;
              },
            ),
            Container(
              height: 1,
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
            ),
            Expanded(child: const PluginList())
          ]),
        ),
      ),
    );
  }
}
