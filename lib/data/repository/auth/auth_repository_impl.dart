import 'package:dartz/dartz.dart';
import 'package:ubify/data/models/auth/create_user_req.dart';
import 'package:ubify/data/models/auth/signin_user_req.dart';
import 'package:ubify/data/sources/auth/auth_firebase_service.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/service_locator.dart';

//REPOSITORY is a bridge between the service and the app domain
//Auth_repo_impl calls signup from the firebase services

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  //call from firebase service the method
  //we want to return the result
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }
}
