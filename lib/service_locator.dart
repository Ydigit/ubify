//servicelocator
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
//here we cofigure the dependecy injections, this pattern helps with services on a application
//sl is a global instnace to centralize the registration and access to the dependencies

//
class SupabaseMusicService {
  final SupabaseClient _client = Supabase.instance.client;

  // Busca músicas mais recentes
  Future<List<Map<String, dynamic>>> fetchSongs() async {
    final response = await _client
        .from('songs') // Nome da tabela
        .select() // Seleciona todas as colunas
        .order('release_date',
            ascending: false) // Ordena pela data de lançamento
        .limit(3) // Limita a 3 músicas
        .execute();

    if (response.status >= 400) {
      print('Erro ao buscar músicas');
      return [];
    }

    return List<Map<String, dynamic>>.from(response.data as List<dynamic>);
  }
}

final sl = GetIt.instance;

//initialize dependecies is used to regiter all dependencies that the app will need
//
//easyer to access
Future<void> initilizeDependencies() async {
  //singleton only one class is created
  //here register the service
  sl.registerSingleton<AuthFirebaseService>(AuthFireBaseServiceImpl());

  //para o supabase service:
  sl.registerSingleton<SongSupabaseService>(SongSupabaseServiceImpl());
  //here register the repository
  //jump to next stage
  //instance of sl (unique) calls the auth_impl
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

//song repo
// Registrar SongRepositoryImpl com o argumento correto
  sl.registerSingleton<SongsRepository>(
    SongRepositoryImpl(sl<SongSupabaseService>()),
  );

  //generates instance for this class
  //this sl instance is used for the UI integration
  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  //register usecase
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  sl.registerSingleton<SupabaseMusicService>(SupabaseMusicService());
}
