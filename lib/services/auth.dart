import 'package:Notey/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  FirebaseAuth _auth;

  AuthService() {
    _auth = FirebaseAuth.instance;
  }

  UserModel _userFromFirebase(User user){
    return user != null ? UserModel(uid: user.uid, email: user.email) : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future registerUser(String email, String password) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //TODO: add user to firestore
      return _userFromFirebase(user);
    } catch(e){
      print('Registring user went wrong.');
      print(e.toString());
      return null;
    }
  }

  Future signout() async {
    return _auth.signOut();
  }

}