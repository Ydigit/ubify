import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/common/widgets/button/basic_app_button.dart';
import 'package:ubify/core/configs/theme/app_theme.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/presentation/auth/pages/signup.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      //logo in appbar
      //we will pass one widget to BasicAppBar
      appBar: BasicAppBar(
        //removes cosnt from scaffold bcs tittle depends on external assets
        //so we remove it to construct in real time compilation
        title: SvgPicture.asset(
          AppVectors.blackSpotifyLogo,
          width: 70,
          height: 70,
        ),
      ),
      //dist from the appbar
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signInText(),
            _signInInputFieldsSpace(),
            _userNameOrEmailFielf(context),
            _inputFieldsSpace(),
            _passwordField(context),
            _signInInputFieldsSpace(),
            BasicAppButton(onPressed: () {}, title: "Sign In"),
          ],
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text(
      "Sign In",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  //BUILDCONTEXT context lets us get access to the current theme and widget tree
  Widget _userNameOrEmailFielf(BuildContext context) {
    //TO ACCESS THE CURRENT THEME
    //as it is alredy defined I dont need to define anythin
    //and theme is alredy choosed
    return TextField(
      decoration: const InputDecoration(hintText: "Enter Username or Email")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
    //APLLY defaults it for
    //use the propertyes from the context's theme on  context.inputDecorationTheme
    //like color edges border for the dark and light theme
    //if not defined we will define this input Decorations
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: "Enter Email")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: "Enter Password")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInInputFieldsSpace() {
    return const SizedBox(
      height: 50,
    );
  }

  Widget _inputFieldsSpace() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Not a Member?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SignupPage(),
                  ));
            },
            child: Text(
              "Register Now!",
            ),
          )
        ],
      ),
    );
  }
}
