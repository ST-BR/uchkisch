import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:uchkisch/modules/plugins/models.dart';

class PluginCommandView extends StatefulWidget {
  const PluginCommandView({required this.command, super.key});
  final PluginCommand command;

  @override
  State<PluginCommandView> createState() => _PluginCommandViewState();
}

class _PluginCommandViewState extends State<PluginCommandView> {
  bool isHovered = false;

  onSelect() async {
    await widget.command.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) {
        if (event.logicalKey.keyId == KeyCode.enter.keyId ||
            event.logicalKey.keyId == KeyCode.space.keyId) {
          onSelect();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      onFocusChange: (isFocused) {
        setState(() {
          isHovered = isFocused;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        onHover: (_) {
          setState(() {
            isHovered = true;
          });
        },
        child: GestureDetector(
          onTap: onSelect,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isHovered
                  ? Theme.of(context).backgroundColor.withOpacity(0.24)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              if (widget.command.icon != null)
                Image(
                  image: widget.command.icon!.image,
                  height: 24,
                  width: 24,
                ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.command.name)
            ]),
          ),
        ),
      ),
    );
  }
}
