import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ubify/data/models/auth/create_user_req.dart';
import 'package:ubify/data/models/auth/signin_user_req.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//how to create a service for authentication
//SERVICE encapsulates the interaction with the API

abstract class AuthFirebaseService {
  //2 methods
  //we need to pass an instance of the create user obj to singup
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
}

class AuthFireBaseServiceImpl extends AuthFirebaseService {
  final _supabaseClient = Supabase.instance.client;
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);
      return const Right("Sign in was successfull");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "invalid-email") {
        message = "Not user found for that email";
      } else if (e.code == "invalid-credential") {
        message = "Wrong password provided fot that user";
      }
      //retorna a message
      return Left(message);
    }
  }

  //como ele recebe um user com os parametros ja posso meter
  //service is alredy receiving the object, and we create the user
  //here I send the data to the Users Table

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      //this userCredential comes with FireBase format need to put it into a text for the supabse id
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: createUserReq.email, password: createUserReq.password);
      //Insert Users in the Table
      await _supabaseClient.from('Users').insert({
        'id': userCredential.user?.uid, // UID from != Supabase
        'email': createUserReq.email,
        'full_name': createUserReq.fullName, //
        'created_at': DateTime.now().toIso8601String(),
      });

      return const Right("Signup was successfull");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "weak-password") {
        message = "The password provided is too weak";
      } else if (e.code == "email-alredy-in-use") {
        message = "An account alredy exists with that email";
      }
      //retorna a message
      return Left(message);
    }
  }
}
