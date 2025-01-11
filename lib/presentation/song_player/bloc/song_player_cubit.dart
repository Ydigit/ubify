import 'package:bloc/bloc.dart';
import 'package:ubify/presentation/song_player/bloc/song_player_state.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit(this.audioPlayer) : super(SongPlayerLoading()) {
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

    audioPlayer.playerStateStream.listen((playerState) {
      emit(SongPlayerStatusState(playerState.playing));
    });
  }

  void loadSong(String songUrl) async {
    try {
      // Stop the current song if playing
      if (audioPlayer.playing) {
        await audioPlayer.stop();
      }

      // Reset state variables
      songDuration = Duration.zero;
      songPosition = Duration.zero;
      emit(SongPlayerLoading());

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
      emit(SongPlayerStatusState(false));
      debugPrint('Song paused');
    } else {
      audioPlayer.play();
      emit(SongPlayerStatusState(true));
      debugPrint('Song playing');
    }
  }

  void skip10Seconds() {
    final newPosition = songPosition + Duration(seconds: 10);
    if (newPosition < songDuration) {
      audioPlayer.seek(newPosition);
    } else {
      audioPlayer.seek(songDuration);
    }
    updateSongPlayer();
  }

  void skip10SecondsBack() {
    final newPosition = songPosition - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      audioPlayer.seek(newPosition);
    } else {
      audioPlayer.seek(Duration.zero);
    }
    updateSongPlayer();
  }

  void updateSongPlayer() {
    // Update the UI or state based on the song position
    emit(SongPlayerPositionUpdated(songPosition));
    debugPrint('Song position: $songPosition');
  }

  bool isPlaying() {
    return audioPlayer.playing;
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}