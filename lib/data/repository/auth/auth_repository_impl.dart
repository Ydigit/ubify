import 'package:ubify/data/models/auth/create_user_req.dart';
import 'package:ubify/data/sources/auth/auth_firebase_service.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/service_locator.dart';

//REPOSITORY is a bridge between the service and the app domain
class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  //call from firebase service the method
  @override
  Future<void> signup(CreateUserReq createUserReq) async {
    await sl<AuthFirebaseService>().signup(createUserReq);
  }
}
