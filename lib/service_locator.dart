import 'package:get_it/get_it.dart';
import 'package:ubify/data/repository/auth/auth_repository_impl.dart';
import 'package:ubify/data/sources/auth/auth_firebase_service.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/domain/usecases/auth/signup.dart';
//here we cofigure the dependecy injections, this pattern helps with services on a application
//sl is a global instnace to centralize the registration and access to the dependencies

//
final service = "Firebase";
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
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
}
