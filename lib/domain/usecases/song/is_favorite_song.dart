import 'package:dartz/dartz.dart';
import 'package:ubify/core/configs/theme/usecase/usecase.dart';
import 'package:ubify/domain/repository/song/song.dart';
import 'package:ubify/service_locator.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
