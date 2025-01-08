import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubify/core/configs/constants/app_urls.dart';
import 'package:ubify/domain/entities/song/song.dart';
import 'package:ubify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:ubify/presentation/song_player/bloc/song_player_state.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;

  const SongPlayerPage({Key? key, required this.songEntity}) : super(key: key);

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
        create: (_) => SongPlayerCubit()..loadSong(songUrl),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _songCover(context, coverUrl),
              const SizedBox(height: 20), // Add space between the image and the text
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
          height: MediaQuery.of(context).size.height / 2, // Make the image shorter
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(coverUrl),
              fit: BoxFit.cover, // Ensure the image covers the container
            ),
            borderRadius: BorderRadius.circular(12), // Optional: Add rounded corners
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
          padding: const EdgeInsets.only(left: 16.0), // Move the text to the right by 16 pixels
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
          padding: const EdgeInsets.only(top: 10.0), // Move the button down by 10 pixels
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline_outlined,
              size: 35,
              color: Colors.grey, // Use a predefined color instead of AppColors.darkGrey
            ),
          ),
        ),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        return Column(
          children: [
            Slider(
              value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
              min: 0.0,
              max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songPosition,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songDuration,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                context.read<SongPlayerCubit>().playOrPauseSong();
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(
                  state is SongPlayingState ? Icons.pause : Icons.play_arrow,
                ),
              ),
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