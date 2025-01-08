import 'package:bloc/bloc.dart';
import 'package:ubify/presentation/song_player/bloc/song_player_state.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        debugPrint('Song duration: $songDuration');
      }
    });
  }

  void loadSong(String songUrl) async {
    try {
      await audioPlayer.setUrl(songUrl);
      emit(SongPlayerLoaded());
      debugPrint('Song loaded: $songUrl');
    } catch (e) {
      emit(SongPlayerFailure());
      debugPrint('Failed to load song: $e');
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
      emit(SongPausedState());
      debugPrint('Song paused');
    } else {
      audioPlayer.play();
      emit(SongPlayingState());
      debugPrint('Song playing');
    }
  }

  void updateSongPlayer() {
    // Update the UI or state based on the song position
    emit(SongPlayerPositionUpdated(songPosition));
    debugPrint('Song position: $songPosition');

  }
}