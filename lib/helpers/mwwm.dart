import 'package:flutter/material.dart';

class Observer extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  const Observer({required this.builder, super.key});

  @override
  State<Observer> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
