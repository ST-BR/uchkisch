import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class CommonInput extends StatefulWidget {
  const CommonInput({
    this.placeholder = '',
    this.onChanged,
    this.onKeyEvent,
    super.key,
  });

  final String placeholder;
  final Function(String)? onChanged;
  final Function(RawKeyEvent)? onKeyEvent;

  @override
  State<CommonInput> createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  final controller = TextEditingController(text: '');
  late final focusNode = FocusNode(onKey: onKey);

  @override
  void initState() {
    controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(controller.text);
      }
    });
    super.initState();
  }

  KeyEventResult onKey(FocusNode node, RawKeyEvent event) {
    if (widget.onKeyEvent != null) {
      widget.onKeyEvent!(event);
    }
    if (event.logicalKey.keyId == KeyCode.arrowUp.keyId) {
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      style: const TextStyle(fontSize: 24),
      autofocus: true,
      decoration:
          InputDecoration.collapsed(hintText: widget.placeholder).copyWith(
        constraints: const BoxConstraints(minHeight: 50),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
      ),
    );
  }
}
