import 'package:flutter/material.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';

class BasicAppButton extends StatelessWidget {
  //no action on pressed
  final VoidCallback onPressed; //in a normal call i doesnt return nothing
  // double or null
  final double? height;
  //tital is a must for button apresentation
  final String title;
  //contruct for required and non required params
  const BasicAppButton(
      {super.key, required this.onPressed, required this.title, this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed, //call void func
        style: ElevatedButton.styleFrom(
            //returned button shld have at leat this min height
            //ig height is null default value is 80
            minimumSize: Size.fromHeight(height ?? 80)),
        //visual part of the button is here
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontSize: 25),
          textAlign: TextAlign.center,
        ));
  }
}
