import 'package:flutter/material.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';
import 'package:ubify/presentation/auth/pages/signup_or_signin.dart';
import 'package:ubify/presentation/choose_mode/pages/choose_mode.dart';

class BasicAppBar extends StatelessWidget {
  const BasicAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
}
