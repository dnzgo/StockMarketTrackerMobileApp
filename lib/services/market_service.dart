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
        return ["SAP", "BMW.DE", "VOW3.DE", "SIE.DE", "MBG.DE"];

      case "TR":
        return ["THYAO.IS", "ASELS.IS", "GARAN.IS", "BIMAS.IS", "AKBNK.IS"];

      case "GB":
        return ["AZN.L", "HSBA.L", "BP.L", "VOD.L", "BARC.L"];

      default:
        return ["AAPL", "MSFT", "NVDA"];
    }
  }
}