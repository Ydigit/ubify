import 'package:flutter/material.dart';

extension IsDarkMode on BuildContext {
  //builContext permite acesso a arvore de widgets
  //needs to check the current theme
  bool get isDarkMode {
    //actual theme of this(contexto atual), verifica o brightness property,
    return Theme.of(this).brightness == Brightness.dark;
  }
}
