abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {}

class SongPlayerFailure extends SongPlayerState {}

class SongPlayingState extends SongPlayerState {}

class SongPausedState extends SongPlayerState {}

class SongPlayerPositionUpdated extends SongPlayerState {
  final Duration position;

  SongPlayerPositionUpdated(this.position);
}