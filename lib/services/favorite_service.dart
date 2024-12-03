import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add Movie to Favorites
  Future<void> addMovieToFavorites({
    required String userId, 
    required String movieId,
  }) async {
    await _firestore.collection('favorite_movies').add({
      'userId': userId,
      'movieId': movieId,
    });
  }

  // Add TV Show to Favorites
  Future<void> addTVShowToFavorites({
    required String userId, 
    required String tvShowId,
  }) async {
    await _firestore.collection('favorite_tvshows').add({
      'userId': userId,
      'tvShowId': tvShowId,
    });
  }

  // Get User's Favorite Movies
  Stream<QuerySnapshot> getUserFavoriteMovies(String userId) {
    return _firestore
      .collection('favorite_movies')
      .where('userId', isEqualTo: userId)
      .snapshots();
  }

  // Get User's Favorite TV Shows
  Stream<QuerySnapshot> getUserFavoriteTVShows(String userId) {
    return _firestore
      .collection('favorite_tvshows')
      .where('userId', isEqualTo: userId)
      .snapshots();
  }

  // Remove Movie from Favorites
  Future<void> removeMovieFromFavorites(String favoriteMovieDocId) async {
    await _firestore.collection('favorite_movies').doc(favoriteMovieDocId).delete();
  }

  // Remove TV Show from Favorites
  Future<void> removeTVShowFromFavorites(String favoriteTVShowDocId) async {
    await _firestore.collection('favorite_tvshows').doc(favoriteTVShowDocId).delete();
  }
}
// Database schema:

// users (collection)
// └── {userId} (document)
//     ├── username: string
//     └── password: string

// favorite_movies (collection)
// └── {favoriteMovieId} (document)
//     ├── userId: string
//     └── movieId: string (from API)

// favorite_tvshows (collection)
// └── {favoriteTVShowId} (document)
//     ├── userId: string
//     └── tvShowId: string (from API)