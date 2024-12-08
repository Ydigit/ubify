import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
//need to develop more here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(AppImages.introBG)),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 10.0, // Para espaço horizontal
                  height: 10.0, // Para espaço vertical
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.spotifyLogo)),
                Spacer(),
                Text(
                  'Enjoy Listening to Music',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 21,
                ),
                Text(
                  'Enjoy the best music from ubi!\n our special music here is "So fe Irmao"',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
              color: Colors.black.withOpacity(0.15) //operates like a filter
              ),
        ],
      ),
    );
  }
}
