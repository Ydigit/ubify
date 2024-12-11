import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/common/widgets/button/basic_app_button.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
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
              alignment: Alignment.center,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //coluna para os elements
                    children: [
                      SvgPicture.asset(
                        AppVectors.blackSpotifyLogo,
                        width: 250.0,
                        height: 250.0,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Enjoy Listening To Music",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0), //horrizontal margin
                        child: Text(
                          "Ubify is a Portuguese audio streaming and media services provider",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign
                              .center, // Centraliza o texto horizontalmente
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            //uses all the space on the row
                            child: BasicAppButton(
                                onPressed: () {}, title: "Register"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color:
                                        context.isDarkMode //se const nao muda
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
