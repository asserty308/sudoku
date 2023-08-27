import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  Size get mediaSize => MediaQuery.of(this).size;
}