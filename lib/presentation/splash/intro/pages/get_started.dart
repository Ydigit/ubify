import 'package:flutter/material.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
//need to develop more here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage(AppImages.introBG))),
          ),
          Container(color: Colors.black.withOpacity(0.15)),
        ],
      ),
    );
  }
}
