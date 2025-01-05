import 'package:dartz/dartz.dart';
import 'package:ubify/domain/entities/song/song.dart';
import 'package:ubify/data/models/song/song.dart';
import 'package:ubify/service_locator.dart';

abstract class SongSupabaseService {
  Future<Either<String, List<SongEntity>>> getNewsSongs();
}

class SongSupabaseServiceImpl extends SongSupabaseService {
  final SupabaseMusicService musicService = sl<SupabaseMusicService>();

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
}
