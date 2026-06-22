class CurrencyService {
  String baseCurrency = "USD";
  String displayCurrency = "EUR";

  double usdToEurRate = 0.87; // temporary fixed rate

  String get currencySymbol {
    switch (displayCurrency) {
      case "USD":
        return "\$";
      case "EUR":
        return "€";
      case "GBP":
        return "£";
      case "TRY":
        return "₺";
      default:
        return displayCurrency;
    }
  }

  double convertFromBase(double value) {
    if (baseCurrency == displayCurrency) {
      return value;
    }

    if (baseCurrency == "USD" && displayCurrency == "EUR") {
      return value * usdToEurRate;
    }

    return value;
  }

  void setDisplayCurrency(String currency) {
    displayCurrency = currency;
  }

  String formatPrice(double value) {
    return "$currencySymbol${value.toStringAsFixed(2)}";
  }

}