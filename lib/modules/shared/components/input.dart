import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class CommonInput extends StatefulWidget {
  const CommonInput({
    this.placeholder = '',
    this.value = '',
    this.onChanged,
    this.onKeyEvent,
    super.key,
  });

  final String value;
  final String placeholder;
  final Function(String)? onChanged;
  final Function(KeyEvent)? onKeyEvent;

  @override
  State<CommonInput> createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  final controller = TextEditingController(text: '');
  late final focusNode = FocusNode(onKeyEvent: onKey);

  @override
  void initState() {
    controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(controller.text);
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommonInput oldWidget) {
    if (oldWidget.value != widget.value) {
      var prevOffset = controller.selection.extentOffset;
      print(prevOffset);

      controller.text = widget.value;
      controller.selection = TextSelection.fromPosition(
        TextPosition(
            offset: prevOffset <= 0 || widget.value.isEmpty ? 0 : prevOffset),
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  KeyEventResult onKey(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (widget.onKeyEvent != null) {
        widget.onKeyEvent!(event);
      }
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
