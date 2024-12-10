import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/widgets/button/basic_app_button.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/presentation/splash/choose_mode/bloc/theme_cubit.dart';

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
              vertical: 20,
              horizontal: 40,
            ),
            child: Column(
              children: [
                const SizedBox(
                  width: 10.0, // Para espaço horizontal
                  height: 2.0, // Para espaço vertical
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.blackSpotifyLogo,
                        width: 250.0, height: 250.0)),
                const Spacer(),
                const Text(
                  'Choose your theme mode',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 21,
                ),
                //button shld be bellow the 2 text promts
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //solving the all blured iamge for only the Container
                    GestureDetector(
                      onTap: () {
                        //update
                        //could create a new instance
                        //ThemeCubit is globally Injected so we use contexr.read
                        context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                      },
                      child: Column(
                        children: [
                          ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff30393C)
                                          .withOpacity(0.5),
                                      shape: BoxShape.circle),
                                  //what is visible on the Container
                                  child: SvgPicture.asset(AppVectors.moon,
                                      fit: BoxFit.none)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Dark Mode',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    Column(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<ThemeCubit>()
                                    .updateTheme(ThemeMode.light);
                              },
                              child: ClipOval(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff30393C)
                                              .withOpacity(0.5),
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(AppVectors.sun,
                                          fit: BoxFit.none)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Light Mode',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: AppColors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ChooseModePage()));
                    }, //Create the ChoseModePage
                    title: 'Continue'),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
