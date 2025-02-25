import 'package:dartz/dartz.dart';
import 'package:ubify/core/configs/theme/usecase/usecase.dart';
import 'package:ubify/data/models/auth/create_user_req.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/service_locator.dart';

//params here are  just the CreateUserReq with respective fields
//dartz lib for
//either class have right and left, on right when success
class SignupUseCase implements UseCase<Either, CreateUserReq> {
  //optional params lets us have more flexibility
  //
  @override
  //
  Future<Either> call({CreateUserReq? params}) {
    //assertive nulity
    //compiler knowd that that value is not null in that moment
    //need to no be null
    return sl<AuthRepository>().signup(params!);
  }
}
