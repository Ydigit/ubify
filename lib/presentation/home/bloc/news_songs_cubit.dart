import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ubify/domain/usecases/song/get_news_songs.dart';
import 'package:ubify/presentation/home/bloc/news_songs_state.dart';
import 'package:ubify/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    debugPrint("Chamando o método getNewsSongs...");
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();

    returnedSongs.fold((error) {
      debugPrint("Falha ao carregar músicas: $error");
      emit(NewSongLoadFailure());
    }, (songs) {
      if (songs.isEmpty) {
        debugPrint("Nenhuma música encontrada.");
      } else {
        debugPrint("Músicas carregadas com sucesso: ${songs.length}");
        for (var song in songs) {
          debugPrint("Título da música: ${song.title}");
        }
      }
      emit(NewsSongsLoaded(songs: songs));
    });
  }
}
