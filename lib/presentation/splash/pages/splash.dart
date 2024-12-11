//new struct
//new splashPage

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/presentation/intro/pages/get_started.dart';

//2sec until strtes page
//convert stateless class to statefull
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  //I initialize the build from state
  //and executing the redirect
  //I get the delay and redirection
  void initState() {
    super.initState();
    redirect();
  }

  //called on the init state and builds
  //after we call de redirect
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AppVectors.blackSpotifyLogo,
            width: 300, height: 300),
      ),
    );
  }

//call this function inside the init state
  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => const GetStartedPage()),
    );
  }
}
