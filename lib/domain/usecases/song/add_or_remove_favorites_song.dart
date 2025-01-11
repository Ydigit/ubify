import 'package:dartz/dartz.dart';
import 'package:ubify/core/configs/theme/usecase/usecase.dart';
import 'package:ubify/domain/repository/song/song.dart';
import 'package:ubify/service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSong(params!);
  }
}
