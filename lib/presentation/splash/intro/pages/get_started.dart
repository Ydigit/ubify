import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/button/basic_app_button.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/presentation/splash/choose_mode/pages/choose_model.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
//need to develop more here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //stack lets us to draw the filter container after the image one
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(AppImages.introBG)),
            ),
          ),
          //this container fills all the area from above container
          Container(
              color: Colors.black.withOpacity(0.15) //operates like a filter
              ),
          Column(
            children: [
              const SizedBox(
                width: 10.0, // Para espaço horizontal
                height: 10.0, // Para espaço vertical
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.spotifyLogo)),
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
        ],
      ),
    );
  }
}//teste main hook

