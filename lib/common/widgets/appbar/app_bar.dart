import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/presentation/auth/pages/signup_or_signin.dart';
import 'package:ubify/presentation/choose_mode/pages/choose_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  //cosntructs with this variable
  final Widget? title; //can be null
  const BasicAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //if title not null display title
        //otherwise display ""
        title: title ?? const Text(""),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //pops the pile nav
          },
          icon: Container(
            //ledding is a container
            height: 50,
            width: 50,
            //this leadding is decorated by a BoxDecoration w color and shape
            //decoration can act like a bg setting
            decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.03)
                    : Colors.black.withOpacity(0.03),
                shape: BoxShape.circle),
            child: Icon(
              //Continer content is the Icon
              Icons.arrow_back_ios_new,
              size: 15,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ) //its composed by the defaault appbar
        );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
