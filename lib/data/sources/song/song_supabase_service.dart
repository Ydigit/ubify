import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ubify/domain/entities/song/song.dart';
import 'package:ubify/data/models/song/song.dart';
import 'package:ubify/service_locator.dart';
import 'package:ubify/domain/usecases/song/is_favorite_song.dart';
import 'package:uuid/uuid.dart';

abstract class SongSupabaseService {
  Future<Either<String, List<SongEntity>>> getNewsSongs();
  //new method get playlist
  Future<Either<String, List<SongEntity>>> getPlayList();
  //new method favorite songs
  Future<Either> addOrRemoveFavoriteSong(String songId);
  //favorite song method
  Future<bool> isFavoriteSong(String songId);
}

class SongSupabaseServiceImpl extends SongSupabaseService {
  final SupabaseMusicService musicService = sl<SupabaseMusicService>();

  SongSupabaseServiceImpl(SupabaseMusicService supabaseMusicService);

  @override
  Future<Either<String, List<SongEntity>>> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];

      var songsData = await musicService.fetchSongs();

      for (var song in songsData) {
        var songModel = SongModel.fromJson(song);

        //could be need to change
        String id = song['id'];

        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(params: id);

        songModel.isFavorite = isFavorite;
        songModel.songId = id;

        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      print(e);
      return const Left('An error occurred, Please try again.');
    }
  }

//get list method _> esta definido no service locator
  @override
  Future<Either<String, List<SongEntity>>> getPlayList() async {
    try {
      List<SongEntity> songs = [];

      var songsData = await musicService.fetchSongs();

      for (var song in songsData) {
        var songModel = SongModel.fromJson(song);

        //could be need to change
        String id = song['id'];

        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(params: id);

        songModel.isFavorite = isFavorite;
        songModel.songId = id;

        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      print(e);
      return const Left('An error occurred, Please try again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      //
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      var userEmail = user?.email;

      if (user == null || userEmail == null) {
        return Left('User not authenticated');
      }

      debugPrint('Authenticated user email: $userEmail');

      final supabase = Supabase.instance.client;

      //may the type casts give errors

      final response = await supabase
          .from('Users')
          .select('id')
          .eq('email', userEmail)
          .single()
          .execute();

      final userData = response.data;

      if (userData == null) {
        return Left('User not found');
      }

      String userId = userData['id'];
      debugPrint(userId);

      // Check if the song is already in the favorites
      final favoriteResponse = await supabase
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .eq('song_id', songId)
          .limit(1)
          .execute();

      late bool isFavorite;

      if (favoriteResponse.data.isNotEmpty) {
        // If the song exists in favorites, remove it
        await supabase
            .from('favorites')
            .delete()
            .eq('user_id', userId)
            .eq('song_id', songId)
            .execute();
        isFavorite = false;
      } else {
        // If the song is not in favorites, add it
        await supabase.from('favorites').insert({
          'user_id': userId,
          'song_id': songId,
        }).execute();
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      debugPrint('Error in addOrRemoveFavoriteSong: $e');
      return Left('An error occurred');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      //
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      var userEmail = user?.email;

      if (user == null || userEmail == null) {
        return false;
      }

      debugPrint('Authenticated user email: $userEmail');

      final supabase = Supabase.instance.client;

      //may the type casts give errors

      final response = await supabase
          .from('Users')
          .select('id')
          .eq('email', userEmail)
          .single()
          .execute();

      final userData = response.data;
      if (userData == null) {
        return false;
      }

      String userId = userData['id'];
      debugPrint(userId);

      // Check if the song is already in the favorites
      final favoriteResponse = await supabase
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .eq('song_id', songId)
          .limit(1)
          .execute();

      if (favoriteResponse.data.isNotEmpty) {
        // If the song exists in favorites, remove it
        return true;
      } else {
        // If the song is not in favorites, add it
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
