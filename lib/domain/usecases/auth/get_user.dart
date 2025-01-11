import 'package:dartz/dartz.dart';
import 'package:ubify/core/configs/theme/usecase/usecase.dart';
import 'package:ubify/data/models/auth/signin_user_req.dart';
import 'package:ubify/domain/repository/auth/auth.dart';
import 'package:ubify/service_locator.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    // Retorna o resultado do repositório
    return await sl<AuthRepository>().getUser();
  }
}
