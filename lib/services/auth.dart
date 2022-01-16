import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// create a class for auth
class AuthService {
  // create object with firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  Userr? _userFromFirebaseUser(User? user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Userr?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? regUser = result.user;
      // this will return according to our user model. only uid....
      return _userFromFirebaseUser(regUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? regUser = result.user;
      // this will return according to our user model. only uid....
      return _userFromFirebaseUser(regUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  // Future is used for those which take some time to happen like async await.
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
