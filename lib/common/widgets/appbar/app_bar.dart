import 'package:flutter/material.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideBackArrow;

  const BasicAppBar({
    super.key,
    this.title,
    this.action,
    this.backgroundColor,
    this.hideBackArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    // This MediaQuery.of offers the height of the safe area
    // Returns sum of heights, bar, and notches if applicable
    final double topPadding = MediaQuery.of(context).padding.top;

    // Using the SafeArea for adjusting the content properly to avoid notch areas
    return SafeArea(
      child: AppBar(
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // Title of the AppBar
        title: Padding(
          // Extra padding for the top
          padding: EdgeInsets.only(top: topPadding),
          child: title ?? const Text(""),
        ),
        // Actions in the AppBar
        actions: [
          action ?? Container(),
        ],
        // Back Arrow button
        // If hideBackArrow is true, return null; otherwise, return the IconButton
        leading: Padding(
          padding:
              EdgeInsets.only(top: topPadding), // Adjusts the "leading" button
          child: hideBackArrow
              ? null
              : IconButton(
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
    // Changed the height for the nav bar
    return Size.fromHeight(kToolbarHeight + topPadding + 5.0);
  }
}
