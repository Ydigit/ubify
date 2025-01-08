import 'package:dartz/dartz.dart';
import 'package:ubify/domain/entities/song/song.dart';
import 'package:ubify/domain/repository/song/song.dart';
import 'package:ubify/data/sources/song/song_supabase_service.dart';

class SongRepositoryImpl extends SongsRepository {
  final SongSupabaseService songSupabaseService;

  SongRepositoryImpl(this.songSupabaseService);

  @override
  Future<Either<String, List<SongEntity>>> getNewsSongs() {
    return songSupabaseService.getNewsSongs();
  }

  @override
  Future<Either> getPlayList() {
    return songSupabaseService.getPlayList();
  }
}
