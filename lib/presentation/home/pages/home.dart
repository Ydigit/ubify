import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';
import 'package:ubify/core/configs/theme/assets/app_images.dart';
import 'package:ubify/core/configs/theme/assets/app_vectors.dart';
import 'package:ubify/presentation/auth/pages/signup_or_signin.dart';
import 'package:ubify/presentation/home/widgets/news_songs.dart';
import 'package:ubify/presentation/home/widgets/play_list.dart';
import 'package:ubify/presentation/profile/pages/profile.dart';

//root class after login
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appbar
        appBar: BasicAppBar(
          hideBackArrow: true,
          action: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ProfilePage()));
              },
              icon: const Icon(Icons.person)),
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
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                children: [
                  NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
                controller: _tabController,
              ),
            ),
            PlayList(),
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

  Widget _tabs() {
    return TabBar(
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        isScrollable: true,
        controller: _tabController,
        indicatorColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        tabs: const [
          Text(
            "News",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            "Videos",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            "Artists",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            "Podcasts",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ]);
  }
}
