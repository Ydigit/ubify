import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubify/common/helpers/is_dark_mode.dart';
import 'package:ubify/common/widgets/appbar/app_bar.dart';
import 'package:ubify/core/configs/constants/app_urls.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';
import 'package:ubify/domain/entities/song/song.dart';
import 'package:ubify/presentation/home/bloc/news_songs_cubit.dart';
import 'package:ubify/presentation/home/bloc/news_songs_state.dart';
import 'package:ubify/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
            builder: (context, state) {
              if (state is NewsSongsLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }
              if (state is NewsSongsLoaded) {
                return _songs(state.songs);
              }
              return Container();
            },
          )),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final coverUrl = AppURLs.getCoverUrl(songs[index].title);

        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context )
              => SongPlayerPage(
                songEntity: songs[index],
                songList: songs,
                currentIndex: index,
              ))
            );
          },
          child: SizedBox(
            width: 160,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1, // Proporção 1:1
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(coverUrl),
                        fit: BoxFit.cover, // Garante que preencha o espaço
                      ),
                      borderRadius: BorderRadius.circular(
                          8), // Opcional para bordas arredondadas
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 40,
                        width: 40,
                        transform: Matrix4.translationValues(10, 10, 0),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: context.isDarkMode
                              ? const Color(0xff959595)
                              : const Color(0xff555555),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode
                                ? AppColors.darkGrey
                                : Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Text(
                    songs[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  songs[index].artist,
                  style:
                      const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemCount: songs.length,
    );
  }
}
