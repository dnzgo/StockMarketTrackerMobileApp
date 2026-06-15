import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/portfolio_holding.dart';

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
      "cashBalance": 10000.00,
      "watchlist": [],
      "createdAt":
      Timestamp.now(),
    });
  }

  Future<Map<String, dynamic>?> getCurrentUserData(String uid) async {
    final document = await _firestore.collection("users").doc(uid).get();
    if(!document.exists) {
      return null;
    }

    return document.data();
  }

  Future<void> updateCashBalance({
    required String uid,
    required double cashBalance,
  }) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .update({
      "cashBalance" : cashBalance
    });
  }

  Future<void> saveHolding({
    required String uid,
    required PortfolioHolding holding,
  }) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("portfolio")
        .doc(holding.stock.symbol)
        .set(holding.toMap()
    );
  }

  // if user sells all shares then delete from db
  Future<void> deleteHolding({
    required String uid,
    required String symbol,
  }) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("portfolio")
        .doc(symbol)
        .delete();
  }

  Future<List<PortfolioHolding>> getHoldings({
    required String uid,
  }) async {
    final snapshot = await _firestore
        .collection("users")
        .doc(uid)
        .collection("portfolio")
        .get();

    return snapshot.docs.map((doc) {
      return PortfolioHolding.fromMap(
        doc.data(),
      );
    }).toList();
  }

}