abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {}

class SongPlayerFailure extends SongPlayerState {}

class SongPlayerStatusState extends SongPlayerState {
  final bool isPlaying;

  SongPlayerStatusState(this.isPlaying);
}

class SongPlayerPositionUpdated extends SongPlayerState {
  final Duration position;

  SongPlayerPositionUpdated(this.position);
}