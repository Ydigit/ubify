import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubify/core/configs/constants/app_urls.dart';
import 'package:ubify/domain/entities/song/song.dart';
import 'package:ubify/presentation/home/bloc/news_songs_cubit.dart';
import 'package:ubify/presentation/home/bloc/news_songs_state.dart';

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
                    child: CircularProgressIndicator());
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

        return SizedBox(
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
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: Text(
                  songs[index].title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8),
              Text(
                songs[index].artist,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 14),
      itemCount: songs.length,
    );
  }
}
