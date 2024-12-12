import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;

  const BasicAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    //This  MediaQuery.of offers the height of the safe area
    //returns sum of heights, bar and notches if applicable
    final double topPadding = MediaQuery.of(context).padding.top;
    //using the safearea for adjusting the content properly for avoiding notch areas
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          //extra padding for for top
          padding: EdgeInsets.only(top: topPadding),
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
      ),
    );
  }

  @override
  Size get preferredSize {
    final double topPadding =
        MediaQueryData.fromView(WidgetsBinding.instance.window).padding.top;
    return Size.fromHeight(kToolbarHeight + topPadding + 50.0);
  }
}
