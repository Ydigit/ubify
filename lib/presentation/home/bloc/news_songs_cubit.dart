import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ubify/domain/usecases/song/get_news_songs.dart';
import 'package:ubify/presentation/home/bloc/news_songs_state.dart';
import 'package:ubify/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();
    returnedSongs.fold((l) {
      emit(NewSongLoadFailure());
    }, (data) {
      emit(NewsSongsLoaded(songs: data));
    });
  }
}
