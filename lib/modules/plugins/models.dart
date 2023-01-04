import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PluginCommand {
  PluginCommand({
    required this.name,
    this.icon,
  });

  String name;
  Image? icon;
  Future<void> execute();
}

abstract class Plugin {
  Plugin({
    required this.name,
    required this.commands,
  });

  String name;
  RxList<PluginCommand> commands;

  Future<void> init();
}
