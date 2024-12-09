import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/button/basic_app_button.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(AppImages.chooseModeBG)),
            ),
          ),
          //this container fills all the area from above container
          Container(
              color: Colors.black.withOpacity(0.15) //operates like a filter
              ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            child: Column(
              children: [
                const SizedBox(
                  width: 10.0, // Para espaço horizontal
                  height: 10.0, // Para espaço vertical
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.blackSpotifyLogo,
                        width: 250.0, height: 250.0)),
                const Spacer(),
                const Text(
                  'Enjoy Listening to Music',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 21,
                ),
                const Text(
                  'Enjoy the best music from ubi!\n our special music here is "So fe Irmao"',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                //button shld be bellow the 2 text promts
                const SizedBox(
                  height: 20,
                ),
                BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ChooseModePage()));
                    }, //Create the ChoseModePage
                    title: 'Get Started'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
