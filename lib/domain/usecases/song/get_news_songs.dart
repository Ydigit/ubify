//U:\Mobile\Project\ubify\lib\domain\usecases\song\get_news_songs.dart
import 'package:dartz/dartz.dart';
import 'package:ubify/core/configs/theme/usecase/usecase.dart';
import 'package:ubify/data/models/auth/create_user_req.dart';
import 'package:ubify/data/repository/song/song_repository_impl.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/service_locator.dart';

//params here are  just the CreateUserReq with respective fields
//dartz lib for
//either class have right and left, on right when success
class GetNewsSongsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepositoryImpl>().getNewsSongs();
  }
  //optional params lets us have more flexibility
  //
}
