import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';
import 'package:stock_market_tracker_mobile_app/widgets/premium_plan_card.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool isMonthlySelected = true;
  String selectedPlan = "Premium";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.center,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: AppColors.textPrimaryColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 16),

              const Text(
                "Upgrade to Premium",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Unlock premium features and\ntake your trading to the next level.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondaryColor,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMonthlySelected = true;
                        });
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isMonthlySelected
                              ? Colors.white.withOpacity(0.15)
                              : Colors.transparent,
                          border: Border.all(
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Monthly",
                            style: TextStyle(
                              color: AppColors.textPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMonthlySelected = false;
                        });
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: !isMonthlySelected
                              ? Colors.white.withOpacity(0.15)
                              : Colors.transparent,
                          border: Border.all(
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Yearly",
                              style: TextStyle(
                                color: AppColors.textPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Save 20%",
                              style: TextStyle(
                                color: AppColors.textSecondaryColor,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 320,
                child: Row(
                  children: [
                    Expanded(
                      child: PremiumPlanCard(
                        title: "Basic",
                        price: "€0",
                        subtitle: "/month",
                        isSelected: selectedPlan == "Basic",
                        onTap: () {
                          setState(() {
                            selectedPlan = "Basic";
                          });
                        },
                        features: const [
                          "Basic stock tracking",
                          "Standard market data",
                          "Limited analytics",
                          "Essential trading tools",
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: PremiumPlanCard(
                        title: "Premium",
                        price: isMonthlySelected
                            ? "€9.99"
                            : "€95.99",
                        subtitle: isMonthlySelected
                            ? "/month"
                            : "/year",
                        isSelected: selectedPlan == "Premium",
                        onTap: () {
                          setState(() {
                            selectedPlan = "Premium";
                          });
                        },
                        features: const [
                          "Real-time alerts",
                          "AI stock insights",
                          "Advanced analytics",
                          "More stock options",
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {},
                child: Container(
                  height: 56,
                  decoration: AppColors.glassButtonDecoration,
                  child: Center(
                    child: Text(
                      "Continue with $selectedPlan",
                      style: const TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}