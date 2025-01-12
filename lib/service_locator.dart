import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ubify/data/repository/auth/auth_repository_impl.dart';
import 'package:ubify/data/repository/song/song_repository_impl.dart';
import 'package:ubify/data/sources/auth/auth_firebase_service.dart';
import 'package:ubify/data/sources/song/song_supabase_service.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/domain/repository/song/song.dart';
import 'package:ubify/domain/usecases/auth/signin.dart';
import 'package:ubify/domain/usecases/auth/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ubify/domain/usecases/song/add_or_remove_favorites_song.dart';
import 'package:ubify/domain/usecases/song/get_favorite_songs.dart';
import 'package:ubify/domain/usecases/song/get_news_songs.dart';
import 'package:ubify/domain/usecases/song/get_play_list.dart';
import 'package:ubify/domain/usecases/song/is_favorite_song.dart';
import 'package:ubify/domain/usecases/auth/get_user.dart';

class SupabaseMusicService {
  final SupabaseClient _client;

  SupabaseMusicService(this._client);

  Future<List<Map<String, dynamic>>> fetchSongs() async {
    debugPrint("Iniciando consulta no Supabase...");

    final response = await _client
        .from('songs') // Nome da tabela
        .select() // Seleciona todas as colunas
        .order('release_date',
            ascending: false) // Ordena pela data de lançamento
        .limit(3) // Limita a 3 músicas
        .execute();

    // Log the status, message, and data
    debugPrint("Resposta status: ${response.status}");
    debugPrint("Resposta mensagem de erro: ${response.errorMessage}");
    debugPrint("Resposta dados: ${response.data}");

    if (response.status >= 400) {
      debugPrint('Erro ao buscar músicas: ${response.errorMessage}');
      return [];
    }

    // Check if data is null or empty
    if (response.data == null || response.data.isEmpty) {
      debugPrint('Nenhuma música encontrada.');
      return [];
    }

    return List<Map<String, dynamic>>.from(response.data as List<dynamic>);
  }

  //get list func fetch musics:
  Future<List<Map<String, dynamic>>> fetchListSongs() async {
    debugPrint("Iniciando consulta no Supabase...");

    final response = await _client
        .from('songs') // Nome da tabela
        .select() // Seleciona todas as colunas
        .order('release_date',
            ascending: false) // Ordena pela data de lançamento
        .execute();

    // Log the status, message, and data
    debugPrint("Resposta status: ${response.status}");
    debugPrint("Resposta mensagem de erro: ${response.errorMessage}");
    debugPrint("Resposta dados: ${response.data}");

    if (response.status >= 400) {
      debugPrint('Erro ao buscar músicas: ${response.errorMessage}');
      return [];
    }

    // Check if data is null or empty
    if (response.data == null || response.data.isEmpty) {
      debugPrint('Nenhuma música encontrada.');
      return [];
    }

    return List<Map<String, dynamic>>.from(response.data as List<dynamic>);
  }
}

extension on PostgrestResponse {
  get errorMessage => null;
}

final sl = GetIt.instance;

Future<void> initilizeDependencies() async {
  final supabaseClient = Supabase.instance.client;

  sl.allowReassignment = true;

  // Registrar SupabaseMusicService
  sl.registerSingleton<SupabaseMusicService>(
    SupabaseMusicService(supabaseClient),
  );

  // Registrar AuthFirebaseService
  sl.registerSingleton<AuthFirebaseService>(AuthFireBaseServiceImpl());

  // Registrar SongSupabaseServiceImpl
  sl.registerSingleton<SongSupabaseService>(
    SongSupabaseServiceImpl(sl<SupabaseMusicService>()),
  );

  // Registrar SongRepositoryImpl
  sl.registerSingleton<SongsRepository>(
    SongRepositoryImpl(sl<SongSupabaseService>()),
  );

  // Registrar AuthRepository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Registrar casos de uso
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase());

  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());
}
