import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
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
      body: const Column(
        children: [],
      ),
    );
  }
}
