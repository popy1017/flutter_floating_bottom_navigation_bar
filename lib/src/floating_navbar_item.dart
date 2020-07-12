import 'package:flutter/material.dart';

class FloatingNavbarItem {
  final Widget title;
  final Widget icon;
  final Widget customWidget;

  FloatingNavbarItem({
    @required this.icon,
    @required this.title,
    this.customWidget = const SizedBox(),
  });
}
