import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool> checkUsernameAvailability(String username) async {
    final querySnapshot = await db
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await createUser(
      uid: result.user!.uid,
      email: email,
      username: username,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> createUser({
    required String uid,
    required String email,
    required String username,
  }) async {
    try {
      await db.collection('users').doc(uid).set(
        {
          'userid': uid,
          'email': email,
          'username': username,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendVerificationEmail() async {
    final user = Auth().currentUser!;
    await user.sendEmailVerification();
  }

  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
