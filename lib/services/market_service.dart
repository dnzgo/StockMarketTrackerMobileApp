class MarketService {
  String selectedMarket = "US";

  void setMarket(String market) {
    selectedMarket = market;
  }

  List<String> get marketSymbols {
    switch (selectedMarket) {
      case "US":
        return ["AAPL", "MSFT", "NVDA", "TSLA", "AMZN", "META", "GOOGL"];

      case "DE":
        return ["SAP", "BMW", "VOW3", "SIE", "MBG"];

      case "TR":
        return ["THYAO", "ASELS", "GARAN", "BIMAS", "AKBNK"];

      case "GB":
        return ["AZN", "HSBA", "BP", "VOD", "BARC"];

      default:
        return ["AAPL", "MSFT", "NVDA"];
    }
  }
}