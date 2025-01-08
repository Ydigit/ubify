import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ubify/domain/usecases/song/get_news_songs.dart';
import 'package:ubify/domain/usecases/song/get_play_list.dart';
import 'package:ubify/presentation/home/bloc/news_songs_state.dart';
import 'package:ubify/presentation/home/bloc/play_list_state.dart';
import 'package:ubify/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    debugPrint("A chamar o metodo getPlayList...");
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    returnedSongs.fold((error) {
      debugPrint("Falha ao carregar as músicas: $error");
      emit(PlayListLoadFailure());
    }, (songs) {
      debugPrint("Músicas carregadas com sucesso: ${songs.length}");
      emit(PlayListLoaded(songs: songs));
    });
  }
}
