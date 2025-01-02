import 'package:get_it/get_it.dart';
import 'package:ubify/data/repository/auth/auth_repository_impl.dart';
import 'package:ubify/data/sources/auth/auth_firebase_service.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/domain/usecases/auth/signin.dart';
import 'package:ubify/domain/usecases/auth/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  //here register the repository
  //jump to next stage
  //instance of sl (unique) calls the auth_impl
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  //generates instance for this class
  //this sl instance is used for the UI integration
  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<SupabaseMusicService>(SupabaseMusicService());
}
