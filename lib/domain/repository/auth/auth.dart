import 'package:dartz/dartz.dart';
import 'package:ubify/data/models/auth/create_user_req.dart';

abstract class AuthRepository {
  // 2 methods signin & signup
  //tipe future
  //
  Future<Either> signup(CreateUserReq createUserReq);
  Future<void> signin();
}
