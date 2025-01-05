import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';
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
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
          ],
        )));
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
          height: 140,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(AppVectors.homeTopCard)),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Image.asset(AppImages.homeArtist),
                  ))
            ],
          )),
    );
  }
}
