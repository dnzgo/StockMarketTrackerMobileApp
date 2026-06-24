class MarketService {
  String selectedMarket = "US";

  void setMarket(String market) {
    selectedMarket = market;
  }

  List<String> get marketSymbols {
    switch (selectedMarket) {
      case "US":
        return ["AAPL", "MSFT", "TSLA"];

      case "DE":
        return ["SAP", "BMW", "VOW3"];

      case "TR":
        return ["THYAO", "ASELS", "GARAN"];

      case "GB":
        return ["AZN", "HSBA", "BP"];

      default:
        return ["AAPL", "MSFT", "TSLA"];
    }
  }
}