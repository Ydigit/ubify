import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/core/configs/theme/app_theme.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _registerText(),
            _registerInputFieldsSpace(),
            _fullNameField(),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField() {
    //as it is alredy defined I dont need to define anythin
    //and theme is alredy choosed
    return TextField();
  }

  Widget _registerInputFieldsSpace() {
    return const SizedBox(
      height: 50,
    );
  }

  Widget _InputFieldsSpace() {
    return const SizedBox(
      height: 15,
    );
  }
}
