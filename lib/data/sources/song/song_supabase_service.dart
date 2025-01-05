import 'package:dartz/dartz.dart';

abstract class SongSupabaseService {
  Future<Either> getNewsSongs();
}


class SongSupabaseServiceImpl extends SongSupabaseService{
  @override
  Future<Either> getNewsSongs() {
    try{List<SongEntity> songs = [];
    var data = await async firebase.firestore.intance.collection.songsorderby("releasedate", descending: true).limit(3).get();
    for (var element in data.docs){
      var  songModel = songModel.fromJSON(element.data());
      //lets convert song model to song entity
      songs.add(
        songModel.toentity()()
      );
      return Right(songs);
    }}catch(e){
      return Left("An error occurred, Please try again.")

    }

    //need to return  the either
  }
}