
import 'package:driver/Commons/constant_strings.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {


  Stream<User?> get UserStream {
    return auth.authStateChanges();
  }

  Future signUpUser({
    required String userEmail,
    required String userPassword,
  }) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: userEmail, password: userPassword);
    return credential.user!.uid;
  }

  Future loginUser({
    required String userEmail,
    required String userPassword,
  }) async{
    UserCredential credential=await auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
    return credential.user!.uid;
}

logOut()async{
   await  auth.signOut();
}
}
