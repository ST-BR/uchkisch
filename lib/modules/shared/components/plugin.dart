import 'package:flutter/material.dart';
import 'package:uchkisch/modules/plugins/models.dart';
import 'package:uchkisch/modules/shared/components/plugin_command.dart';

class PluginView extends StatefulWidget {
  const PluginView(
      {required this.commands, required this.pluginName, super.key});
  final String pluginName;
  final Iterable<PluginCommand> commands;

  @override
  State<PluginView> createState() => _PluginViewState();
}

class _PluginViewState extends State<PluginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.commands.isEmpty) {
      return Container();
    }

    return Container(
        child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 4, bottom: 6, left: 2, right: 2),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.4)),
          child: Text(
            widget.pluginName,
          ),
        ),
        Column(
          children: widget.commands
              .map((command) => PluginCommandView(command: command))
              .toList(),
        )
      ],
    ));
  }
}
