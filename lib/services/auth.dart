import 'package:Notey/models/user_model.dart';
import 'package:Notey/services/note_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth _auth;

  AuthService({FirebaseAuth firebaseAuth}) : _auth = firebaseAuth ?? FirebaseAuth.instance;

  UserModel _userFromFirebase(User user){
    return user != null ? UserModel(uid: user.uid, email: user.email) : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future registerUser(String email, String password) async{
    print('ENTER');
    try {
      print('enter');
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      UserModel userModel = _userFromFirebase(user);
      FirebaseFirestore.instance.collection('users').doc('${user.uid}').set(userModel.toMap());
      return userModel;
    } catch(e){
      print('Registring user went wrong.');
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(credential.user);
    } catch (e) {
      print('Couldn\'t sign in');
      print(e.toString());
      return null;
    }
  }

  Future googleSignIn() async {
    try{
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication signInAuthentication = await googleSignInAccount.authentication;

      AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken
      );

      UserCredential userCredential = await _auth.signInWithCredential(authCredential);
      User user = userCredential.user;

      if(userCredential.additionalUserInfo.isNewUser){
        UserModel userModel = _userFromFirebase(user);
        FirebaseFirestore.instance.collection('users').doc('${user.uid}').set(userModel.toMap());
      }

      return user;
    } catch(e){
      print('Couldn\'t sign in');
      print(e.toString());
      return null;
    }
  }

  Future signout() async {
    return _auth.signOut();
  }

  bool isSignedIn() {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  UserModel getUser(){
    return _userFromFirebase(_auth.currentUser);
  }

}