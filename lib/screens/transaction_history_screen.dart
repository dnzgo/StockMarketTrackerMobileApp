import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transaction_record.dart';
import '../services/auth_service.dart';
import '../services/service_locator.dart';
import '../services/user_service.dart';
import '../utils/app_theme.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends State<TransactionHistoryScreen> {
  final authService = AuthService();
  final userService = UserService();

  List<TransactionRecord> transactions = [];
  bool isLoading = true;

  Future<void> loadTransactions() async {
    final user = authService.currentUser;
    if (user == null) return;

    final loadedTransactions =
    await userService.getTransactions(uid: user.uid);

    if (!mounted) return;

    setState(() {
      transactions = loadedTransactions;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.bottomRight,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: AppColors.textPrimaryColor,
          ),
          title: const Text(
            "Transaction History",
            style: TextStyle(
              color: AppColors.textPrimaryColor,
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];

            final type = transaction.type;
            final symbol = transaction.symbol;
            final quantity = transaction.quantity;
            final price = transaction.price;
            final totalAmount = transaction.totalAmount;
            final tradeDate = transaction.createdAt == null
                ? ""
                : DateFormat("dd/MM/yy HH:mm").format(transaction.createdAt!);

            final isBuy = type == "buy";

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: AppColors.glassCardDecoration,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${type.toUpperCase()} $symbol",
                        style: TextStyle(
                          color: isBuy
                              ? AppColors.increasedValueColor
                              : AppColors.decreasedValueColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$quantity shares at ${currencyService.formatPrice(price)}",
                        style: const TextStyle(
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                      Text(
                        tradeDate,
                        style: const TextStyle(
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    currencyService.formatPrice(totalAmount),
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}