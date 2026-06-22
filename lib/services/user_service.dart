import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/portfolio_holding.dart';
import '../models/transaction_record.dart';

class UserService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String firstName,
    required String surname,
    required String email,
    required String selectedCountry,
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
      "selectedCountry": selectedCountry,
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

  Future<void> updateSelectedCountry({
    required String uid,
    required String countryCode,
  }) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .update({
      "selectedCountry": countryCode,
    });
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

  // add stocks to watchlist avoid duplicates
  Future<void> addToWatchlist({
    required String uid,
    required String symbol,
  }) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .update({"watchlist" : FieldValue.arrayUnion([symbol])
    });
  }
  // remove if stock is in watchlist
  Future<void> removeFromWatchlist({
    required String uid,
    required String symbol,
  }) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .update({"watchlist" : FieldValue.arrayRemove([symbol])
    });
  }

  Future<bool> isWatchlisted({
    required String uid,
    required String symbol,
  }) async {
    try {
      final document = await _firestore
          .collection("users")
          .doc(uid)
          .get();

      final data = document.data();

      if (data == null) {
        return false;
      }

      final watchlist =
      List<String>.from(data["watchlist"] ?? []);

      return watchlist.contains(symbol);
    } catch (e) {
      print("WATCHLIST ERROR: $e");
      return false;
    }
  }

  Future<List<String>> getWatchlist({
    required String uid,

  }) async {
    final document = await _firestore
        .collection("users")
        .doc(uid).get();

    final data = document.data();

    if (data == null) return [];

    return List<String>.from(data["watchlist"] ?? []);
  }

  Future<void> saveTransaction({
    required String uid,
    required TransactionRecord transaction,
  }) async {
    await _firestore
        .collection("users")
        .doc(uid)
        .collection("transactions")
        .add({
      ...transaction.toMap(),
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getTransactions({
    required String uid,
  }) async {
    final snapshot = await _firestore
        .collection("users")
        .doc(uid)
        .collection("transactions")
        .orderBy("createdAt", descending: true)
        .get();

    return snapshot.docs
        .map((doc) => doc.data())
        .toList();
  }

}