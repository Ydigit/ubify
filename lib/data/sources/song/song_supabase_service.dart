import 'package:dartz/dartz.dart';
import 'package:ubify/domain/entities/song/song.dart';
import 'package:ubify/data/models/song/song.dart';
import 'package:ubify/service_locator.dart';

abstract class SongSupabaseService {
  Future<Either<String, List<SongEntity>>> getNewsSongs();
  //new method get playlist
  Future<Either<String, List<SongEntity>>> getPlayList();
}

class SongSupabaseServiceImpl extends SongSupabaseService {
  final SupabaseMusicService musicService = sl<SupabaseMusicService>();

  SongSupabaseServiceImpl(SupabaseMusicService supabaseMusicService);

  @override
  Future<Either<String, List<SongEntity>>> getNewsSongs() async {
    try {
      // Busca músicas usando o SupabaseMusicService
      final songsData = await musicService.fetchSongs();

      // Converte os dados em SongEntity
      final songs =
          songsData.map((song) => SongModel.fromJson(song).toEntity()).toList();

      return Right(songs);
    } catch (e) {
      return Left('Erro ao buscar músicas: $e');
    }
  }

//get list method _> esta definido no service locator
  @override
  Future<Either<String, List<SongEntity>>> getPlayList() async {
    try {
      // Busca músicas usando o SupabaseMusicService
      final songsData = await musicService.fetchSongs();

      // Converte os dados em SongEntity
      final songs =
          songsData.map((song) => SongModel.fromJson(song).toEntity()).toList();

      return Right(songs);
    } catch (e) {
      return Left('Erro ao buscar músicas: $e');
    }
  }
}
