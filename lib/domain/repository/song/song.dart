//U:\Mobile\Project\ubify\lib\domain\repository\song\song.dart
import 'package:dartz/dartz.dart';

abstract class SongsRepository {
  //get news songs
  Future<Either> getNewsSongs();
}
