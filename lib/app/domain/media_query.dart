import 'package:flutter/material.dart';

extension MediaQueryExt on BuildContext {
  Size get mediaSize => MediaQuery.of(this).size;
}
