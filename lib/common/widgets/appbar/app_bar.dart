import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/presentation/auth/pages/signup_or_signin.dart';
import 'package:ubify/presentation/choose_mode/pages/choose_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;

  const BasicAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(
            top: topPadding + 20.0), // Adiciona espaço extra fixo
        child: title ?? const Text(""),
      ),
      leading: Padding(
        padding: EdgeInsets.only(top: topPadding), // Ajusta o botão "leading"
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.03)
                  : Colors.black.withOpacity(0.03),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 15,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    final double topPadding =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;

    // Adiciona espaço fixo extra para o título
    return Size.fromHeight(kToolbarHeight + topPadding + 20.0);
  }
}
