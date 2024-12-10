import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //patterns
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          //image
          Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(AppImages.authImage)),
          Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                AppVectors.blackSpotifyLogo,
                width: 250.0,
                height: 250.0,
              )),
        ],
      ),
    );
  }
}
