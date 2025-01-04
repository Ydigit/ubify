import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';

//root class after login
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: BasicAppBar(
        hideBackArrow: true,
        //removes cosnt from scaffold bcs tittle depends on external assets
        //so we remove it to construct in real time compilation
        //remove or jide the back button
        title: SvgPicture.asset(
          AppVectors.blackSpotifyLogo,
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}
