import 'package:dartz/dartz.dart';
import 'package:ubify/core/configs/theme/usecase/usecase.dart';
import 'package:ubify/data/models/auth/signin_user_req.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/service_locator.dart';

//params here are  just the SigninUserReq with respective fields
//dartz lib for
//either class have right and left, on right when success
class SigninUseCase implements UseCase<Either, SigninUserReq> {
  //optional params lets us have more flexibility
  //
  @override
  //
  Future<Either> call({SigninUserReq? params}) {
    //assertive nulity
    //compiler knowd that that value is not null in that moment
    //need to no be null
    return sl<AuthRepository>().signin(params!);
  }
}
