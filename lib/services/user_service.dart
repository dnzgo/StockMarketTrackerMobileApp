import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String firstName,
    required String surname,
    required String email,
  }) async {

    await _firestore
        .collection("users")
        .doc(uid)
        .set({
      "firstName": firstName,
      "surname": surname,
      "email": email,
      "cashBalance": 10000,
      "watchlist": [],
      "createdAt":
      Timestamp.now(),
    });
  }
}