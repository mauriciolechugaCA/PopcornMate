import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User Registration
  Future<User?> registerUser({
    required String username, 
    required String email, 
    required String password
  }) async {
    try {
      // Create user with Firebase Authentication
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      User? user = result.user;
      
      if (user != null) {
        // Store additional user info in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
        });
        
        return user;
      }
      
      return null;
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  // User Login
  Future<User?> loginUser({
    required String email, 
    required String password
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return result.user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Add to Favorites
  Future<void> addToFavorites({
    required String userId,
    required String itemId,
    required String itemType
  }) async {
    try {
      await _firestore.collection('favorites').add({
        'userId': userId,
        'itemId': itemId,
        'itemType': itemType,
      });
    } catch (e) {
      print('Error adding to favorites: $e');
    }
  }

  // Get User's Favorites
  Stream<QuerySnapshot> getUserFavorites(String userId) {
    return _firestore
      .collection('favorites')
      .where('userId', isEqualTo: userId)
      .snapshots();
  }
}