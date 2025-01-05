//service_locator
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
  final _client = Supabase.instance.client;

  // Listar músicas com metadados
  Future<List<Map<String, dynamic>>> fetchSongs() async {
    final response = await _client.from('songs').select();

    if (response.error != null) {
      print('Erro ao buscar músicas: ${response.error?.message}');
      return [];
    }

    return List<Map<String, dynamic>>.from(response.data);
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
  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());

  //generates instance for this class
  //this sl instance is used for the UI integration
  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  //register usecase
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  sl.registerSingleton<SupabaseMusicService>(SupabaseMusicService());
}
