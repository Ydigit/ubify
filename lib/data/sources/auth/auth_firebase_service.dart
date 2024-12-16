import 'package:firebase_auth/firebase_auth.dart';
import 'package:ubify/data/models/auth/create_user_req.dart';

//how to create a service for authentication
//SERVICE encapsulates the interaction with the API

abstract class AuthFirebaseService {
  //2 methods
  //we need to pass an instance of the create user obj to singup
  Future<void> signup(CreateUserReq createUserReq);
  Future<void> signin();
}

class AuthFireBaseServiceImpl extends AuthFirebaseService {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  //como ele recebe um user com os parametros ja posso meter
  //service is alredy receiving the object, and we create the user
  @override
  Future<void> signup(CreateUserReq createUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);
    } on FirebaseAuthException catch (e) {}
  }
}
