import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ubify/domain/entities/auth/user.dart';
import 'package:flutter/foundation.dart';
import 'package:ubify/domain/usecases/auth/get_user.dart';
import 'package:ubify/presentation/profile/bloc/profile_info_state.dart';
import 'package:ubify/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUseCase>().call();

    user.fold((l) {
      debugPrint('ProfileInfoCubit: Error loading user - $l');
      emit(ProfileInfoFailure());
    }, (userEntity) {
      emit(ProfileInfoLoaded(userEntity: userEntity));
    });
  }
}
