//U:\Mobile\Project\ubify\lib\data\repository\song\song_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:ubify/domain/repository/song/song.dart';

class SongRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getNewsSongs() {
    return sl<SongFirebaseServices>().getNewsSongs();
  }
}
