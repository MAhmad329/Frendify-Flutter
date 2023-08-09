import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

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
    required String name,
  }) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await createUser(
      uid: result.user!.uid,
      email: email,
      username: username,
      name: name,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> createUser({
    required String uid,
    required String email,
    required String username,
    required String name,
  }) async {
    try {
      await db.collection('users').doc(uid).set(
        {
          'userid': uid,
          'email': email,
          'username': username,
          'name': name,
          'following': [],
          'followers': [],
          'pfp': '',
        },
      );
    } on firebase_core.FirebaseException catch (e) {
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

  // Future<void> deleteAllFilesInStorage() async {
  //   try {
  //     // Get a reference to the root of Firebase Storage
  //     Reference rootReference = FirebaseStorage.instance.ref();
  //
  //     // List all items (files and folders) at the root location.
  //     // The listAll() method gives a list of items and prefixes, where items are files, and prefixes are folders.
  //     final result = await rootReference.listAll();
  //
  //     // Delete all files
  //     for (final item in result.items) {
  //       await item.delete();
  //       print('Deleted file: ${item.fullPath}');
  //     }
  //
  //     // Delete all subfolders
  //     for (final prefix in result.prefixes) {
  //       await deleteFolderContent(prefix);
  //     }
  //
  //     print('All data in Firebase Storage has been deleted.');
  //   } catch (e) {
  //     print('Failed to delete data in Firebase Storage: $e');
  //   }
  // }
  //
  // Future<void> deleteFolderContent(Reference folderRef) async {
  //   try {
  //     final result = await folderRef.listAll();
  //
  //     // Delete all files in the folder
  //     for (final item in result.items) {
  //       await item.delete();
  //       print('Deleted file: ${item.fullPath}');
  //     }
  //
  //     // Delete all subfolders
  //     for (final prefix in result.prefixes) {
  //       await deleteFolderContent(prefix);
  //     }
  //
  //     // Delete the folder itself
  //     await folderRef.delete();
  //     print('Deleted folder: ${folderRef.fullPath}');
  //   } catch (e) {
  //     print('Failed to delete folder content: $e');
  //   }
  // }
}
