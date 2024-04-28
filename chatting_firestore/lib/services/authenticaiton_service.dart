import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Login with email and password
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
      
        final User loggedInUser = User(
          uid: user.uid,
          email: user.email!,
        );
        return loggedInUser;
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<User?> registerWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        
        final User registeredUser = User(
          uid: user.uid,
          email: user.email!,
        );
        return registeredUser;
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}