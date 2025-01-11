import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';
import 'package:ubify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:ubify/presentation/profile/bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor:
            context.isDarkMode ? AppColors.darkGrey : AppColors.lightBackground,
        title: Text('Profile'),
      ),
      body: Column(
        children: [_profileInfo(context)],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: context.isDarkMode ? Color(0xff2C2B2B) : Colors.white,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    state.userEntity.fullName!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(state.userEntity.email!)
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return const Text('Please try again');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
