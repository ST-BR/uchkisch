import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plist_parser/plist_parser.dart';

import '../models.dart';

class ApplicationsPlugin extends Plugin {
  ApplicationsPlugin()
      : super(
          name: "Applications",
          commands: RxList(),
        );

  Future<Image?> _getAppIcon(String path) async {
    try {
      final plist = await PlistParser().parseFile("$path/Contents/Info.plist");
      final cfBundleIconFile = plist['CFBundleIconFile'].toString();
      final iconFileName = cfBundleIconFile.endsWith('.icns')
          ? cfBundleIconFile
          : "$cfBundleIconFile.icns";
      final iconPath = "$path/Contents/Resources/$iconFileName";

      return Image.file(File(iconPath));
    } catch (_) {
      return null;
    }
  }

  @override
  Future init() async {
    var appsDir = Directory('/Applications');
    var apps = await appsDir.list().toList().then((entries) => entries
        .whereType<Directory>()
        .where((entry) => entry.path.split('.').last == 'app')
        .toList());

    var commands = await Future.wait(
      apps.map(
        (entry) async {
          return ApplicationCommandItem(
              path: entry.path,
              name: entry.path.split('/').last.split('.').first,
              icon: await _getAppIcon(entry.path));
        },
      ).toList(),
    );

    this.commands.assignAll(commands);
  }
}

class ApplicationCommandItem extends PluginCommand {
  String path;
  ApplicationCommandItem(
      {required String name, Image? icon, required this.path})
      : super(icon: icon, name: name);

  @override
  execute() async {
    try {
      await Process.run('open', [path]);
    } catch (err) {
      print(err);
    }
  }
}
