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
import 'package:ubify/domain/usecases/song/get_news_songs.dart';

class SupabaseMusicService {
  final SupabaseClient _client;

  SupabaseMusicService(this._client);

  Future<List<Map<String, dynamic>>> fetchSongs() async {
    final response = await _client
        .from('songs')
        .select()
        .order('release_date', ascending: false)
        .limit(3)
        .execute();

    if (response.status >= 400) {
      print('Erro ao buscar músicas');
      return [];
    }

    return List<Map<String, dynamic>>.from(response.data as List<dynamic>);
  }
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
}
