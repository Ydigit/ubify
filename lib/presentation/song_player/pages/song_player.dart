import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubify/common/widgets/favorite_button/favorite_button.dart';
import 'package:ubify/core/configs/constants/app_urls.dart';
import 'package:ubify/domain/entities/song/song.dart';
import 'package:ubify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:ubify/presentation/song_player/bloc/song_player_state.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  final List<SongEntity> songList;
  final int currentIndex;

  const SongPlayerPage({
    Key? key,
    required this.songEntity,
    required this.songList,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coverUrl = AppURLs.getCoverUrl(songEntity.title);
    final songUrl = AppURLs.getSongUrl(songEntity.title);

    debugPrint('Cover URL: $coverUrl');
    debugPrint('Song URL: $songUrl');

    return Scaffold(
      appBar: AppBar(
        title: Text(songEntity.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit(AudioPlayer())..loadSong(songUrl),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _songCover(context, coverUrl),
              const SizedBox(
                  height: 20), // Add space between the image and the text
              _songDetail(),
              const SizedBox(height: 30),
              _songPlayer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context, String coverUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Transform.translate(
        offset: const Offset(0, 10), // Pull the image down by 10 pixels
        child: Container(
          height:
              MediaQuery.of(context).size.height / 2, // Make the image shorter
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(coverUrl),
              fit: BoxFit.cover, // Ensure the image covers the container
            ),
            borderRadius:
                BorderRadius.circular(12), // Optional: Add rounded corners
          ),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 16.0), // Move the text to the right by 16 pixels
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songEntity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                songEntity.artist,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
                top: 10.0), // Move the button down by 10 pixels
            child: FavoriteButton(songEntity: songEntity)),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        final songCubit = context.read<SongPlayerCubit>();
        debugPrint('Current state: $state');
        return Column(
          children: [
            Slider(
              value: songCubit.songPosition.inSeconds.toDouble(),
              min: 0.0,
              max: songCubit.songDuration.inSeconds.toDouble(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    formatDuration(songCubit.songPosition),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    formatDuration(songCubit.songDuration),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    if (currentIndex > 0) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPlayerPage(
                            songEntity: songList[currentIndex - 1],
                            songList: songList,
                            currentIndex: currentIndex - 1,
                          ),
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.replay_10),
                  onPressed: songCubit.skip10SecondsBack,
                ),
                GestureDetector(
                  onTap: () {
                    songCubit.playOrPauseSong();
                    debugPrint(
                        'Play/Pause button tapped. Current state: ${songCubit.state}');
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      songCubit.isPlaying() ? Icons.pause : Icons.play_arrow,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10),
                  onPressed: songCubit.skip10Seconds,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    if (currentIndex < songList.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPlayerPage(
                            songEntity: songList[currentIndex + 1],
                            songList: songList,
                            currentIndex: currentIndex + 1,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
